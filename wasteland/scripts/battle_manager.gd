extends Control

var contenders = {}
var turn_order = []
var turn_idx = 0
var movedict = Moves.moves

func _ready():
	randomize()

func set_battle(enemies):
	contenders.clear()
	turn_idx = 0

	# Loop through each party member name in current_stats
	for member in GameState.party_members:
		var stats = GameState.base_stats[member].duplicate()
		stats["hp"] = GameState.current_stats[member]["hp"]
		stats["mp"] = GameState.current_stats[member]["mp"]

		contenders[member] = stats

	# Add the enemy
	if typeof(enemies) == TYPE_ARRAY:
		for i in range(enemies.size()):
			var enemy = enemies[i]
			var id = "%s_%d" % [enemy["name"], i]
			contenders[id] = enemy
	elif typeof(enemies) == TYPE_OBJECT: # Node
		var id = enemies.name
		contenders[id] = enemies.stats

	# print("Contenders:", contenders)

	det_order()

	# TODO: change scene to battle (start battle, effectively)
	var battle_overlay = preload("res://scenes/Battle.tscn").instantiate()
	get_tree().current_scene.add_child(battle_overlay)
	battle_overlay.setUI(contenders)

	battle()

func battle():
	# Run the battle right here (#8)
	
	'''
	while true:
		run_turn()

		# End if no party members left
		var party_alive = false
		var enemy_alive = false
		for contender in turn_order:
			if GameState.party_members.has(contender):
				party_alive = true
			else:
				enemy_alive = true

		if !party_alive or !enemy_alive:
			print("Battle ended!")

			break
	'''

func run_turn():
	var current_name = turn_order[turn_idx]
	var current = contenders[current_name]

	if GameState.party_members.has(current_name):
		# Player turn
		var move = current["moveset"].pick_random()
		var target_name = pick_target(false)
		apply_move(current_name, move, target_name)
	else:
		# Enemy turn
		var move = current["moveset"].pick_random()
		var target_name = pick_target(true)
		apply_move(current_name, move, target_name)

	# Advance turn
	turn_idx = (turn_idx + 1) % turn_order.size()

func apply_move(user_name: String, move_name: String, target_name: String):
	var user = contenders[user_name]
	var target = contenders[target_name]
	var move = movedict[move_name]

	# Deduct MP cost
	user["mp"] -= move["cost"]

	match move["type"]:
		"attack":
			target["hp"] -= move["power"]
			target["hp"] = max(target["hp"], 0)  # clamp to 0
			print("%s used %s on %s! %s HP is now %d" %
				[user_name, move_name, target_name, target_name, target["hp"]])

		"heal":
			target["hp"] += move["power"]
			target["hp"] = clamp(target["hp"], 0, target["max_hp"])  # clamp between 0 and max
			print("%s used %s! %s HP is now %d" %
				[user_name, move_name, target_name, target["hp"]])

	# Check defeat
	if target["hp"] <= 0:
		print("%s has been defeated!" % target_name)

		var idx = turn_order.find(target_name)
		if idx != -1:
			turn_order.remove_at(idx)

			# Adjust turn_idx if needed
			if turn_order.size() > 0:
				turn_idx = turn_idx % turn_order.size()
			else:
				turn_idx = 0

		contenders.erase(target_name)
		# print("Turn order after erase:", turn_order)

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
