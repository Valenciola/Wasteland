extends Control

func show_inventory(inventory: Dictionary):
	visible = true
	var list = $PanelContainer/HBoxContainer/ItemList
	list.clear()
	for item_name in inventory.keys():
		var amount = inventory[item_name]
		list.add_item("%s x%d" % [item_name, amount])

func hide_inventory():
	visible = false

func _ready():
	var list = $PanelContainer/HBoxContainer/ItemList
	list.connect("item_selected", Callable(self, "_on_item_selected"))

func _on_item_selected(index: int):
	var list = $PanelContainer/HBoxContainer/ItemList
	var text = list.get_item_text(index)
	var item_name = text.split(" x")[0]  # extract name before " xN"

	var data = Items.items[item_name]

	$VBoxContainer/NameLabel.text = data["name"]
	$VBoxContainer/DescriptionLabel.text = data["description"]
	$VBoxContainer/EffectLabel.text = data.get("effect", "")
	# If you want to show degree or type:
	# $VBoxContainer/ExtraLabel.text = "%s (%d)" % [data["type"], data.get("degree", 0)]

func _process(_delta):
	if visible and Input.is_action_just_pressed("ui_cancel"):
		hide_inventory()
