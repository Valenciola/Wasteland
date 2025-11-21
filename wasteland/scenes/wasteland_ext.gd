extends Node2D

func _ready():
    call_deferred("_place_player")

func _place_player():
    var player = get_tree().get_root().get_node("Player")
    if GameState.next_spawn_point != "":
        var spawn = get_node_or_null(GameState.next_spawn_point)
        if player and spawn:
            player.global_position = spawn.global_position