extends Node2D

@export var crate_id: String
var player_nearby: bool = false
signal crate_opened(inventory)
var crate_inventory: Dictionary

var box
var hud
var empty = false

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))
	add_to_group("crates")

	crate_inventory = GameState.crates[crate_id]

	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	hud = get_tree().root.get_node("Main/HUD")
	box.dialogue_finished.connect(_on_dialogue_finished)

	# Find the InventoryUI node and connect directly
	var ui = get_tree().get_root().get_node("Main/UI/InventoryUI")  # adjust path
	if ui:
		connect("crate_opened", Callable(ui, "_on_crate_opened"))
	else:
		print("InventoryUI not found at expected path!")


func _on_body_entered(body):
	if body.name == "Player":
		player_nearby = true

func _on_body_exited(body):
	if body.name == "Player":
		player_nearby = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		interact()

func interact():
	if crate_inventory.is_empty():
		print("This crate is empty.")
		empty = true
		box.show_dialogue([
			["[Player]", "Looks like this crate is empty…"],
		])
		return
	elif crate_id == "redhouse" and !GameState.flags["open_house_crate"]:
		box.show_dialogue([
			["[Player]", "There's still materials in here…"],
			["[Player]", "Am I gonna die if I eat these…?"],
			["[Player]", "Then again, I'm definitely gonna die if I don't eat anything…"],
			["[Player]", "I might as well hold onto this stuff, since it doesn't seem like anyone else is coming for it."],
			["TIP", "You can add items from crates to your inventory. Press Esc to close the inventory afterwards."]
		], false)
		GameState.flags["open_house_crate"] = true
	else:
		print("Emitting crate_opened with:", crate_inventory)
		emit_signal("crate_opened", crate_inventory)


	print("Crate contains:")
	for item_name in crate_inventory.keys():
		var amount = crate_inventory[item_name]
		print("- %s x%d" % [item_name, amount])

func get_inventory() -> Dictionary:
	return crate_inventory

func _on_dialogue_finished():
	if empty:
		empty = false
		return
	elif GameState.flags["open_house_crate"]:
		emit_signal("crate_opened", crate_inventory)
