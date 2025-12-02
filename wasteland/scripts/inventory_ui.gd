extends Control

var inventory = GameState.inventory
var null_icon = preload("res://assets/icons/Null.png")

var hud

# Track whether we're viewing a crate
var is_crate_view: bool = false

func _ready():
	print("InventoryUI ready at path:", get_path())
	populate_inventory()
	hide()
	hud = get_tree().root.get_node("Main/HUD/HUD")

	$Panel/HBoxContainer/VBoxContainer/Button.hide()  # default hidden
	$Panel/HBoxContainer/VBoxContainer/Button.pressed.connect(_on_take_all_pressed)

	$Panel/HBoxContainer/Details/IconFull.texture = null_icon
	$Panel/HBoxContainer/Details/Title.text = "-"
	$Panel/HBoxContainer/Details/Description.text = "Select an item to see its details."

func _on_crate_opened(crate_inventory: Dictionary):
	print("UI received crate inventory:", crate_inventory)
	inventory = crate_inventory
	is_crate_view = true
	populate_inventory()
	show()
	hud.hide()
	GameState.player_can_move = false
	$Panel.show()
	$Panel/HBoxContainer/VBoxContainer/Button.show()  # only show in crate view

func open_personal_inventory():
	print("Opening personal inventory from HUD")
	inventory = GameState.inventory
	is_crate_view = false
	populate_inventory()
	show()
	hud.hide()
	GameState.player_can_move = false
	$Panel.show()
	$Panel/HBoxContainer/VBoxContainer/Button.hide()  # hide in personal view

func _on_take_all_pressed():
	if not is_crate_view:
		return  # safety
	
	print("Take All pressed")
	for item_id in inventory.keys():
		var count = inventory[item_id]
		if count > 0:
			# Merge into GameState
			if not GameState.inventory.has(item_id):
				GameState.inventory[item_id] = 0
			GameState.inventory[item_id] += count

	# Clear the crate contents
	inventory.clear()

	# Repopulate (will show empty grid)
	populate_inventory()

	# Close inventory
	hide()
	hud.show()
	GameState.player_can_move = true
	print("GameState inventory after take all:", GameState.inventory)

func populate_inventory():
	var grid = $Panel/HBoxContainer/VBoxContainer/Inventory
	clear(grid)
	for item_id in inventory.keys():
		var count = inventory[item_id]
		if count > 0:
			var slot = preload("res://scenes/InventorySlot.tscn").instantiate()
			grid.add_child(slot)
			slot.call_deferred("setup", item_id, count)
			slot.pressed.connect(_on_slot_pressed.bind(item_id))
	
	$Panel/HBoxContainer/Details/IconFull.texture = null_icon
	$Panel/HBoxContainer/Details/Title.text = "-"
	$Panel/HBoxContainer/Details/Description.text = "Select an item to see its details."

func _on_slot_pressed(item_id):
	var item_data = Items.items[item_id]
	var tex = null_icon
	if item_data.has("icon"):
		if typeof(item_data["icon"]) == TYPE_STRING:
			var loaded = load(item_data["icon"])
			if loaded:
				tex = loaded
		else:
			tex = item_data["icon"]

	$Panel/HBoxContainer/Details/IconFull.texture = tex
	$Panel/HBoxContainer/Details/Title.text = item_data["name"]
	$Panel/HBoxContainer/Details/Description.text = item_data["description"]

func clear(container: Node):
	for child in container.get_children():
		child.queue_free()

func _process(_delta):
	if is_visible_in_tree() and Input.is_action_just_pressed("ui_cancel"):
		hide()
		hud.show()
		GameState.player_can_move = true
		print("Inventory closed with Esc")
