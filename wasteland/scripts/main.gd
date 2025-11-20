extends Node2D

func _ready():
	print("Scene is alive!")
	var currName = GameState.player_name

	$Dialogue/DialogueBox.show_dialogue([
		[currName, "Hello there!"],
		["???", "This is a test dialogue."],
		[currName, "Press Enter to continue."],
		["Valerie", "Carving out the steps..."]
	])
