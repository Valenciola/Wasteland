extends Node2D

func _ready():
	print("Scene is alive!")
	# print_tree_pretty()

	var currName = GameState.player_name
	var box = $Dialogue/DialogueBox