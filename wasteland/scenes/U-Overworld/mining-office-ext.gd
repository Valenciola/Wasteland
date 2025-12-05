extends Area2D

@export var target_scene : String = "res://scenes/U-Interiors/Mining-Office-Int.tscn"   # scene to load
@export var spawn_point_name : String = "Mine-Off-Spawn"                 # marker name in target scene

var player_inside = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		player_inside = true
		print("Player entered house exit trigger")

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false
		print("Player left house exit trigger")

func _process(_delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		print("E pressed at exit, swapping to:", target_scene)
		GameState.next_spawn_point = spawn_point_name
		_swap_map()

func _swap_map():
	var new_map = load(target_scene).instantiate()
	var current_map_node = get_tree().root.get_node("Main/CurrentMap")

	# clear out the old map
	for child in current_map_node.get_children():
		print("Removing old map child:", child.name)
		child.queue_free()

	# add the new one
	current_map_node.add_child(new_map)
	print("New map added:", new_map.name)

	# move player to the spawn point
	var spawn = new_map.get_node_or_null(spawn_point_name)
	if spawn:
		Player.global_position = spawn.global_position   # Player is autoload singleton
		print("Player moved to spawn:", spawn_point_name, "at", spawn.global_position)
	else:
		print("Spawn point not found:", spawn_point_name)
