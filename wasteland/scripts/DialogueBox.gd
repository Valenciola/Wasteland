extends Control

# Basic controller for the dialogue engine (#5)

var dialogue_queue = []
var current_index = 0

func show_dialogue(lines: Array):
	dialogue_queue = lines
	current_index = 0
	visible = true
	$Panel/MarginContainer/VBoxContainer/Speaker.text = dialogue_queue[current_index][0]
	$Panel/MarginContainer/VBoxContainer/Dialogue.text = dialogue_queue[current_index][1]
	GameState.player_can_move = false

func _input(event):
	if visible and event.is_action_pressed("ui_accept"):
		current_index += 1
		if current_index < dialogue_queue.size():
			$Panel/MarginContainer/VBoxContainer/Speaker.text = dialogue_queue[current_index][0]
			$Panel/MarginContainer/VBoxContainer/Dialogue.text = dialogue_queue[current_index][1]
			GameState.player_can_move = false
		else:
			visible = false
			GameState.player_can_move = true
