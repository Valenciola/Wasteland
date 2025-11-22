extends Control

var inventory = GameState.inventory
var null_icon = preload("res://assets/icons/Null.png")

func _ready():
	print("InventoryUI ready at path:", get_path())
	populate_inventory()
	hide()  # start hidden until a crate is opened

func _on_crate_opened(crate_inventory: Dictionary):
	print("UI received crate inventory:", crate_inventory)
	inventory = crate_inventory
	populate_inventory()
	show()
	$Panel.show()  # ensure the panel itself is visible

func populate_inventory():
	var grid = $Panel/HBoxContainer/Inventory
	clear(grid)
	for item_id in inventory.keys():
		var count = inventory[item_id]
		if count > 0:
			var slot = preload("res://scenes/InventorySlot.tscn").instantiate()
			grid.add_child(slot)
			slot.call_deferred("setup", item_id, count)
			slot.pressed.connect(_on_slot_pressed.bind(item_id))

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
