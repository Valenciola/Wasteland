extends CharacterBody2D

var speed = 150  # pixels per second

func _physics_process(_delta):
	var direction = Vector2.ZERO

	if GameState.player_can_move:

		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.y += 1
		if Input.is_action_pressed("ui_up"):
			direction.y -= 1

		velocity = direction.normalized() * speed
		move_and_slide()

func hide_for_menu():
	visible = false
	set_process(false)
	if $Camera2D:
		$Camera2D.enabled = false

func show_for_game():
	visible = true
	set_process(true)
	if $Camera2D:
		$Camera2D.enabled = true
