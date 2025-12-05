extends Node2D

var box

func _ready():
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	box.dialogue_finished.connect(_on_dialogue_finished)

	if !GameState.flags["arrived_in_utopia"]:
		var spawn = get_node_or_null("U-Start")
		if spawn:
			Player.global_position = spawn.global_position
			print("Player placed at TrainSpawn:", spawn.global_position)
		else:
			print("Spawn point not found in Train Station")
		
		$Tren.show()
		await get_tree().create_timer(0.2).timeout
		box.show_dialogue(Lines.utrainarrival)
		GameState.flags["arrived_in_utopia"] = true

func _on_dialogue_finished():
	pass
