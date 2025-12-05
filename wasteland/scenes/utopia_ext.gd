extends Node2D

var box

func _ready():
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	box.dialogue_finished.connect(_on_dialogue_finished)

	if !GameState.flags["tren_warned"] and GameState.flags["met_utopian_leader"]:
		$"Tren-In".show()
		$"Arihara-In".show()

		# Enable physics when shown
		_set_physics_enabled($"Tren-In", true)
		_set_physics_enabled($"Arihara-In", true)

		await get_tree().create_timer(0.4).timeout
		box.show_dialogue(Lines.tren_warning)
		GameState.flags["tren_warned"] = true
	else:
		# Keep them hidden and disable physics
		$"Tren-In".hide()
		$"Arihara-In".hide()
		_set_physics_enabled($"Tren-In", false)
		_set_physics_enabled($"Arihara-In", false)

func _set_physics_enabled(node: Node, enabled: bool):
	# If they’re CharacterBody2D or RigidBody2D
	if node is CharacterBody2D or node is RigidBody2D:
		node.set_physics_process(enabled)

	# If they have a CollisionShape2D child
	var shape = node.get_node_or_null("CollisionShape2D")
	if shape:
		shape.disabled = !enabled

func _on_dialogue_finished():
	pass
