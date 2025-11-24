extends Control

func _ready():
	$HBoxContainer/Button.pressed.connect(_on_inventory_button_pressed)

func _on_inventory_button_pressed():
	var ui = get_tree().get_root().get_node("Main/UI/InventoryUI")
	if ui:
		ui.open_personal_inventory()
