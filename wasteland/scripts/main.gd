extends Node2D

var flags = GameState.flags

func _ready():
	Player.show_for_game()
	var box = $Dialogue/DialogueBox
	box.dialogue_finished.connect(_on_dialogue_finished)

	await get_tree().create_timer(1.0).timeout
	# Don't show the HUD when the first cutscene finishes; main will control HUD timing
	box.show_dialogue(Lines.yourmission1, false)

func _on_dialogue_finished():
	if !flags["intro"]:
		await ScreenFX.fade_out(2.0)
		await get_tree().create_timer(1.0).timeout
		$Dialogue/DialogueBox.show_dialogue(Lines.yourmission2)
		flags["intro"] = true