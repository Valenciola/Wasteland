extends Control

var contenders
var heroes = []
var enemies = []
var selecting_target: bool = false
var living = []
var target_index: int = 0
var move_name_cache: String = ""

func _ready():
	set_process_unhandled_input(true)

func setUI(peeps: Dictionary):
	contenders = peeps
	heroes.clear()
	enemies.clear()
	$CanvasLayer/HBoxContainer/Menu/HBoxContainer/RichTextLabel.clear()
	# print_tree_pretty()

	for key in contenders.keys(): # Split heroes and enemies for the purpose of display
		if key in GameState.party_members:
			heroes.append(key)
		else:
			enemies.append(key)
	
	clear() # Erase previous things
	
	for i in range(0, len(heroes)): # Set heroes
		var num = i + 1
		var hero = heroes[i]
		var slot_path = "CanvasLayer/HBoxContainer/Contenders/Player-S/Players/Player " + str(num)
		var slot = get_node(slot_path)

		var details = """%s

		HP: %d/%d
		MP: %d/%d""" % [hero, contenders[hero]["hp"], contenders[hero]["max_hp"], contenders[hero]["mp"], contenders[hero]["max_mp"]]

		slot.get_node("RichTextLabel").text = details
		slot.get_node("TextureRect").texture = load("res://assets/models/characters/" + hero.to_lower() + ".png")

	for i in range(0, len(enemies)): # Set enemies
		var num = i + 1
		var enemy = enemies[i]
		var slot_path = "CanvasLayer/HBoxContainer/Contenders/Enemy-S/Enemies/Enemy " + str(num)
		var slot = get_node(slot_path)

		var details = """%s

		HP: %d
		MP: %d""" % [contenders[enemy]["name"], contenders[enemy]["hp"], contenders[enemy]["mp"]]

		slot.get_node("RichTextLabel").text = details
		slot.get_node("TextureRect").texture = load("res://assets/models/entities/" + contenders[enemy]["name"].to_lower() + ".png")
	
	# Populate buttons
	var grid = $CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer
	clear_children(grid)

	var actions = ["Attack", "Item", "Flee"]
	for action in actions:
		var btn = Button.new()
		btn.text = action

		# Expand horizontally and vertically
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL

		btn.pressed.connect(func(): _on_menu_action(action))

		grid.add_child(btn)

func set_moves():
	var actions = ["Attack", "Item", "Flee"]
	var grid = $CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer
	clear_children(grid)
	grid.visible = true

	for action in actions:
		var btn = Button.new()
		btn.text = action

		# Expand horizontally and vertically
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL

		btn.pressed.connect(func(): _on_menu_action(action))

		grid.add_child(btn)

func _on_menu_action(action: String):
	var subject = BattleManager.turn_order[BattleManager.turn_idx]
	match action:
		"Attack":
			show_moveset(subject)

func show_moveset(actor_name: String):
	var grid = $CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer
	clear_children(grid)

	var moves = contenders[actor_name]["moveset"]

	for move_name in moves:
		var btn = Button.new()
		btn.text = Moves.moves[move_name]["name"]
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
		btn.pressed.connect(func(): _on_move_selected(actor_name, move_name, false))
		grid.add_child(btn)

	# Add Back button
	var back_btn = Button.new()
	back_btn.text = "Back"
	back_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	back_btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
	back_btn.pressed.connect(func(): set_moves())
	grid.add_child(back_btn)

func _on_move_selected(actor_name: String, move_name: String, side: bool):
	selecting_target = true
	$CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer.visible = false
	living.clear()
	move_name_cache = move_name

	if side:
		for hero in heroes:
			if contenders[hero]["hp"] > 0:
				living.append(hero)
	else:
		for enemy in enemies:
			if contenders[enemy]["hp"] > 0:
				living.append(enemy)

	if living.is_empty():
		selecting_target = false
		$CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer.visible = true
		add_message("No valid targets.")
		reset_highlights()
		return
	
	target_index = 0
	reset_highlights()
	highlight_target(living[target_index])

func add_message(msg: String):
	$CanvasLayer/HBoxContainer/Menu/HBoxContainer/RichTextLabel.append_text(msg + "\n")

func clear():
	# Erase Things
	var slot_path
	var slot

	for i in range(1, 4):
		slot_path = "CanvasLayer/HBoxContainer/Contenders/Player-S/Players/Player %d" % i
		slot = get_node(slot_path)

		# Clear label
		slot.get_node("RichTextLabel").text = ""

		# Clear texture
		slot.get_node("TextureRect").texture = null
	
	for i in range(1, 4):
		slot_path = "CanvasLayer/HBoxContainer/Contenders/Enemy-S/Enemies/Enemy %d" % i
		slot = get_node(slot_path)

		# Clear label
		slot.get_node("RichTextLabel").text = ""

		# Clear texture
		slot.get_node("TextureRect").texture = null

func clear_children(container: Control):
	for child in container.get_children():
		child.queue_free()

func reset_highlights():
	for i in range(heroes.size()):
		var h_slot = get_node("CanvasLayer/HBoxContainer/Contenders/Player-S/Players/Player %d" % (i+1))
		h_slot.get_node("TextureRect").modulate = Color(1,1,1)
	for i in range(enemies.size()):
		var e_slot = get_node("CanvasLayer/HBoxContainer/Contenders/Enemy-S/Enemies/Enemy %d" % (i+1))
		e_slot.get_node("TextureRect").modulate = Color(1,1,1)

func highlight_target(target_name: String):
	var idx = heroes.find(target_name)
	if idx != -1:
		var h_slot = get_node("CanvasLayer/HBoxContainer/Contenders/Player-S/Players/Player %d" % (idx+1))
		h_slot.get_node("TextureRect").modulate = Color(1.3,1.3,1.3)
	else:
		idx = enemies.find(target_name)
		if idx != -1:
			var e_slot = get_node("CanvasLayer/HBoxContainer/Contenders/Enemy-S/Enemies/Enemy %d" % (idx+1))
			e_slot.get_node("TextureRect").modulate = Color(1.3,1.3,1.3)

func _unhandled_input(event):
	if selecting_target:
		if event.is_action_pressed("ui_down"):
			target_index = (target_index + 1) % living.size()
			reset_highlights()
			highlight_target(living[target_index])
		elif event.is_action_pressed("ui_up"):
			target_index = (target_index - 1 + living.size()) % living.size()
			reset_highlights()
			highlight_target(living[target_index])
		elif event.is_action_pressed("ui_accept"):
			selecting_target = false
			reset_highlights()
			$CanvasLayer/HBoxContainer/Menu/HBoxContainer/GridContainer.visible = true
			BattleManager.apply_move(
				BattleManager.turn_order[BattleManager.turn_idx],
				move_name_cache,
				living[target_index]
			)
