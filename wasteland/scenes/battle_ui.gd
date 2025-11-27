extends Control

var contenders

func setUI(peeps: Dictionary):
	var heroes = []
	var enemies = []
	contenders = peeps
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
		btn.pressed.connect(func(): _on_move_selected(actor_name, move_name))
		grid.add_child(btn)

	# Add Back button
	var back_btn = Button.new()
	back_btn.text = "Back"
	back_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	back_btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
	back_btn.pressed.connect(func(): set_moves())
	grid.add_child(back_btn)

func _on_move_selected(actor_name: String, move_name: String):
	# For now, auto-pick a target (later you’ll add target selection UI)
	var target = BattleManager.pick_target(false)
	BattleManager.apply_move(actor_name, move_name, target)

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
