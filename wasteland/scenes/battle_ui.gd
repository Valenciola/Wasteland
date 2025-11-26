extends Control

func setUI(contenders: Dictionary):
	var heroes = []
	var enemies = []
	print_tree_pretty()

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

		grid.add_child(btn)

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
