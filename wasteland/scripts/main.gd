extends Node2D

func _ready():
	print("Scene is alive!")
	# print_tree_pretty()

	var currName = GameState.player_name
	var box = $Dialogue/DialogueBox

	box.show_dialogue([
		[currName, "Hello there!"],
		["???", "This is a test dialogue."],
		[currName, "Press Enter to continue."],
		["Valerie", "Carving out the steps..."]
	])
