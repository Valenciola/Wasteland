extends Area2D

@export var target_scene : String = "res://scenes/W-Interiors/HouseRed-Int.tscn"        # scene to load
@export var spawn_point_name : String = "HouseRed-entry"    # marker name in target scene

var player_inside = false

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))
    connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
    if body.name == "Player":
        player_inside = true

func _on_body_exited(body):
    if body.name == "Player":
        player_inside = false

func _process(_delta):
    if player_inside and Input.is_key_pressed(KEY_E): # direct E key for now
        GameState.next_spawn_point = spawn_point_name
        get_tree().call_deferred("change_scene_to_file", target_scene)