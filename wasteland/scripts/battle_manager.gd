extends Control

var contenders = {}
var turn_order = []
var turn_idx = 0
var movedict = Moves.moves
var BattleOverlayScene = preload("res://scenes/Battle.tscn")
var battle_overlay: Node = null

func _ready():
	randomize()

func set_battle(enemies):
	contenders.clear()
	turn_idx = 0

	# Add party members
	for member in GameState.party_members:
		var stats = GameState.base_stats[member].duplicate()
		stats["hp"] = GameState.current_stats[member]["hp"]
		stats["mp"] = GameState.current_stats[member]["mp"]
		contenders[member] = stats

	# Add enemies
	if typeof(enemies) == TYPE_ARRAY:
		for i in range(enemies.size()):
			var enemy = enemies[i]
			var id = ""
			var stats = null

			if typeof(enemy) == TYPE_DICTIONARY:
				id = "%s_%d" % [enemy["name"], i]
				stats = enemy
			elif typeof(enemy) == TYPE_OBJECT:
				id = "%s_%d" % [enemy.stats["name"], i]
				stats = enemy.stats

			if stats != null:
				contenders[id] = stats

	elif typeof(enemies) == TYPE_DICTIONARY:
		var id = enemies["name"]
		contenders[id] = enemies

	elif typeof(enemies) == TYPE_OBJECT: # Node with .stats
		var id = enemies.stats["name"]
		contenders[id] = enemies.stats

	print("Contenders:", contenders)

	det_order()

	battle_overlay = BattleOverlayScene.instantiate()
	get_tree().current_scene.add_child(battle_overlay)
	battle_overlay.setUI(contenders)

	battle()

func battle():
	# Run the battle right here (#8)
	print(turn_order)
	run_turn()

func run_turn():
	var current_name = turn_order[turn_idx]
	
	# Skip if contender was defeated and removed
	if !contenders.has(current_name):
		turn_idx = (turn_idx + 1) % turn_order.size()
		run_turn()
		return
	
	var current = contenders[current_name]

	if GameState.party_members.has(current_name):
		# Player turn
		battle_overlay.set_moves()
	else:
		# Enemy turn
		var move = current["moveset"].pick_random()
		var target_name = pick_target(true)
		apply_move(current_name, move, target_name)

func end_turn():
	# Advance index
	await get_tree().create_timer(1.0).timeout
	turn_idx = (turn_idx + 1) % turn_order.size()

	# Check win/lose conditions
	var party_alive = false
	var enemy_alive = false
	for contender in turn_order:
		if GameState.party_members.has(contender):
			party_alive = true
		else:
			enemy_alive = true

	if !party_alive or !enemy_alive:
		print("Battle ended!")
		if !party_alive:
			battle_overlay.add_message("Your party has been defeated...")
		elif !enemy_alive:
			battle_overlay.add_message("Victory! All enemies defeated.")

		# Remove the battle overlay
		await get_tree().create_timer(1).timeout
		battle_overlay.queue_free()
		battle_overlay = null

		if !GameState.flags["beat_zombie"]:
			await get_tree().create_timer(1).timeout
			get_tree().root.get_node("Main/Dialogue/DialogueBox").show_dialogue([
				["[Player]", "Wha…"],
				["[Player]", "I don't know what's scarier… being attacked by whatever that was or…"],
				["[Player]", "The fact that that's the only living thing I've seen here, if that even qualifies as living…"],
				["[Player]", "I… I really need help. There must be someone around. That voice can't be too far away. I have to keep looking…"]
			])
		elif !GameState.flags["fought_reb"]:
			await get_tree().create_timer(1).timeout
			get_tree().root.get_node("Main/Dialogue/DialogueBox").show_dialogue([
				["[Player]", "Phew..."],
				["Rebel", "I can't believe this... so you'd rather side with these oppressors?"],
				["[Player]", "They're just trying to promote peace... I can't let you destablize this."],
				["Rebel", "Just... get lost. Before we make you regret it."],
				["[Player]", "We?"],
				["Rebel", "The revolution."]
			])

		return

	# Run next turn
	run_turn()

func apply_move(user_name: String, move_name: String, target_name: String):
	var user = contenders[user_name]
	var target = contenders[target_name]
	var move = movedict[move_name]

	battle_overlay.get_node("CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer").visible = false # Hide the grid and use the move

	# Deduct MP cost
	user["mp"] -= move["cost"]
	user["mp"] = max(user["mp"], 0)

	match move["type"]:
		"attack":
			target["hp"] -= move["power"]
			target["hp"] = max(target["hp"], 0)  # clamp to 0
			battle_overlay.add_message("%s used %s on %s! %s HP is now %d" %
				[user_name, move["name"], target_name, target_name, target["hp"]])

		"heal":
			target["hp"] += move["power"]
			target["hp"] = clamp(target["hp"], 0, target["max_hp"])  # clamp between 0 and max
			battle_overlay.add_message("%s used %s on %s! %s HP is now %d" %
				[user_name, move["name"], target_name, target["hp"]])
	
	battle_overlay.refresh_ui()

	# Check defeat
	if target["hp"] <= 0:
		battle_overlay.add_message("%s has been defeated!" % target_name)
		var idx = turn_order.find(target_name)
		if idx != -1:
			turn_order.remove_at(idx)
			if idx < turn_idx:
				turn_idx -= 1
		contenders.erase(target_name)

	end_turn()

# Helper functions
func det_order():
	var temp = []

	for cont in contenders.keys():
		temp.append({"name": cont, "stats": contenders[cont]})
	
	temp.sort_custom(Callable(self, "_sort_by_speed"))

	turn_order.clear()
	for entry in temp:
		turn_order.append(entry["name"])

	# print(turn_order)

func _sort_by_speed(a, b):
	return a["stats"]["speed"] > b["stats"]["speed"]

func pick_target(from_party: bool) -> String:
	var candidates = []
	for contender in turn_order:
		var stats = contenders[contender]
		var is_party = GameState.party_members.has(contender)

		# Only add living contenders on the correct side
		if stats["hp"] > 0:
			if from_party and is_party:
				candidates.append(contender)
			elif !from_party and !is_party:
				candidates.append(contender)

	if candidates.size() == 0:
		return ""

	# Pick a random candidate
	return candidates[randi() % candidates.size()]
