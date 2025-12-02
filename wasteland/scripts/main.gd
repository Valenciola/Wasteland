extends Node2D

var flags = GameState.flags
var hud

func _ready():
	Player.show_for_game()
	var box = $Dialogue/DialogueBox
	box.dialogue_finished.connect(_on_dialogue_finished)

	hud = $HUD/HUD

	await get_tree().create_timer(1.0).timeout
	# Don't show the HUD when the first cutscene finishes; main will control HUD timing
	box.show_dialogue(Lines.yourmission1, false)

func _on_dialogue_finished():
	var box = $Dialogue/DialogueBox
	var cam = Player.get_node("Camera2D")

	# First cutscene finished
	if !flags["intro"]:
		await ScreenFX.fade_out(2.0)
		await get_tree().create_timer(1.0).timeout
		box.show_dialogue(Lines.yourmission2, false)
		flags["intro"] = true

	# Second cutscene finished (player wakes up)
	elif flags["intro"] and !flags["house_seen"]:
		GameState.player_can_move = false
		hud.hide()

		# Pan to house
		var house = $"CurrentMap/Wasteland-ext/HouseRed-ext"
		var house_pos = house.global_position

		var tween = create_tween()
		tween.tween_property(cam, "global_position", house_pos, 2.0)
		await tween.finished

		await get_tree().create_timer(1.0).timeout

		# Show tutorial dialogue (about the house)
		box.show_dialogue([
			["[Player]", "Oh, it's a house…"],
			["[Player]", "Maybe the person who spoke to me lives inside?"]
		], false)

		flags["house_seen"] = true

	# House dialogue finished
	elif flags["house_seen"] and !flags["tutorial_done"]:
		# Pan back to player
		var tween = create_tween()
		tween.tween_property(cam, "global_position", Player.global_position, 2.0)
		await tween.finished

		# Hand control back
		GameState.player_can_move = true
		hud.show()
		flags["tutorial_done"] = true
