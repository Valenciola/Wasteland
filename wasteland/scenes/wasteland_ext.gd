extends Node2D

var box
var hud
var zombie
var cam

enum CutsceneState { NONE, EXIT_DIALOGUE_DONE, ZOMBIE_DIALOGUE_DONE }
var cutscene_state: int = CutsceneState.NONE

func _ready():
	call_deferred("_place_player")

	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	hud = get_tree().root.get_node("Main/HUD")
	zombie = $Zombie
	cam = Player.get_node("Camera2D")

	box.dialogue_finished.connect(_on_dialogue_finished)

	# Trigger only when exiting the house for the first time
	if GameState.next_spawn_point == "HouseRed-exit" and !GameState.flags["battled_zombie"]:
		zombie.visible = true
		GameState.player_can_move = false
		await get_tree().create_timer(0.4).timeout
		box.show_dialogue(Lines.surpriseencounter1, false)

func _place_player():
	var player = get_tree().get_root().get_node("Player")
	if GameState.next_spawn_point != "":
		var spawn = get_node_or_null(GameState.next_spawn_point)
		if player and spawn:
			player.global_position = spawn.global_position

func _on_dialogue_finished():
	if GameState.flags["in_red_house"]:
		match cutscene_state:
			CutsceneState.NONE:
				# First block finished → pan to zombie and show second block
				cutscene_state = CutsceneState.EXIT_DIALOGUE_DONE
				await _pan_camera_to(zombie.global_position, 1.2)
				box.show_dialogue(Lines.surpriseencounter2, false)

			CutsceneState.EXIT_DIALOGUE_DONE:
				# Second block finished → pan back, hide zombie, start battle
				cutscene_state = CutsceneState.ZOMBIE_DIALOGUE_DONE
				var player = get_tree().get_root().get_node("Player")
				await _pan_camera_to(player.global_position, 1.0)
				zombie.visible = false
				_start_zombie_battle()

func _pan_camera_to(target_pos: Vector2, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(cam, "global_position", target_pos, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func _start_zombie_battle():
	GameState.flags["battled_zombie"] = true
	# Keep movement locked; battle manager will own input
	var zombie_stats = {
		"name": "Zombie",
		"hp": 30,
		"max_hp": 30,
		"mp": 0,
		"speed": 0.3,
		"moveset": ["Bite", "Kick", "Punch"]  # must exist in Moves.moves
	}
	BattleManager.set_battle(zombie_stats)
