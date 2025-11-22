extends Node2D

@export var crate_inventory: Dictionary
var player_nearby: bool = false
signal crate_opened(inventory)

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

	connect("crate_opened", Callable(Player, "_on_crate_opened"))

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
		return
	emit_signal("crate_opened", crate_inventory)

	print("Crate contains:")
	for item_name in crate_inventory.keys():
		var amount = crate_inventory[item_name]
		print("- %s x%d" % [item_name, amount])

func get_inventory() -> Dictionary:
	return crate_inventory
