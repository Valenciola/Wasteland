extends Control

var dialogue_queue = []
var current_index = 0
var hud
var typing = false
var full_text = ""
var _show_hud_on_finish: bool = true

signal dialogue_finished

@onready var speaker_label = $Panel/MarginContainer/VBoxContainer/Speaker
@onready var dialogue_label = $Panel/MarginContainer/VBoxContainer/Dialogue

func _ready() -> void:
	hud = get_tree().root.get_node("Main/HUD/HUD")

func show_dialogue(lines: Array, show_hud_on_finish: bool = true):
	dialogue_queue = lines
	current_index = 0
	visible = true
	_show_line()
	_show_hud_on_finish = show_hud_on_finish
	hud.hide()
	GameState.player_can_move = false

func _show_line():
	var speaker = dialogue_queue[current_index][0]
	var text = dialogue_queue[current_index][1]

    # Replace placeholders before typing
	speaker_label.text = speaker.replace("[Player]", GameState.player_name)
	full_text = text.replace("[Player]", GameState.player_name)

	dialogue_label.text = ""   # start empty
	typing = true
	_type_text()

func _type_text() -> void:
	for i in range(full_text.length()):
		dialogue_label.text += full_text[i]
		await get_tree().create_timer(0.03).timeout  # typing speed
		if not typing:   # skip if player pressed confirm
			dialogue_label.text = full_text
			break
	typing = false


func _input(event):
	if visible and event.is_action_pressed("ui_accept"):
		if typing:
			# Skip typing, show full line immediately
			typing = false
			dialogue_label.text = full_text
		else:
            # Advance to next line
			current_index += 1
			if current_index < dialogue_queue.size():
				_show_line()
				GameState.player_can_move = false
				hud.hide()
			else:
				visible = false
				GameState.player_can_move = true
				if _show_hud_on_finish:
					hud.show()
				emit_signal("dialogue_finished")