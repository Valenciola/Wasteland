extends Control

@onready var name_input = $Panel/VBoxContainer/LineEdit
@onready var start_button = $Panel/VBoxContainer/HBoxContainer/Button

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	Player.hide_for_menu()

func _on_start_pressed():
	GameState.player_name = name_input.text.strip_edges()
	if GameState.player_name == "":
		GameState.player_name = "You"

	await ScreenFX.fade_in(2.0)
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
