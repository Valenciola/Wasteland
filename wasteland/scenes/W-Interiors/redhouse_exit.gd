extends Area2D

@export var target_scene : String = "res://scenes/Wasteland-Ext.tscn"   # scene to load when exiting
@export var spawn_point_name : String = "HouseRed-exit"                 # marker name in target scene

var player_inside = false
var box
var hud

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))
    connect("body_exited", Callable(self, "_on_body_exited"))

    box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
    hud = get_tree().root.get_node("Main/HUD")
    box.dialogue_finished.connect(_on_dialogue_finished)

    # --- trigger house entry cutscene only first time ---
    if !GameState.flags["in_red_house"]:
        GameState.player_can_move = false
        await get_tree().create_timer(1.0).timeout

        box.show_dialogue([
            ["[Player]", "Huh? It's empty…"],
            ["[Player]", "In fact… it seems like nobody's been here in a while. What's up with that?"],
            ["[Player]", "I wonder if it's safe to investigate further…"],
            ["TIP", "Remember, you can approach items and press \'E\' to interact with them."]
        ])

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

func _swap_map() -> void:
    var new_map = load(target_scene).instantiate()
    var current_map_node = get_tree().root.get_node("Main/CurrentMap")

    for child in current_map_node.get_children():
        print("Removing old map child:", child.name)
        child.queue_free()

    current_map_node.add_child(new_map)
    print("New map added:", new_map.name)

    var spawn = new_map.get_node_or_null(spawn_point_name)
    if spawn:
        Player.global_position = spawn.global_position
        print("Player moved to spawn:", spawn_point_name, "at", spawn.global_position)
    else:
        print("Spawn point not found:", spawn_point_name)

func _on_dialogue_finished():
    if !GameState.flags["in_red_house"]:
        GameState.flags["in_red_house"] = true
        GameState.player_can_move = true
        hud.show()
