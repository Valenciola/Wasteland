extends Node2D

func _ready():
	if !GameState.flags["met_utopian_leader"]:
		$"Enf-cap".hide()
		_set_physics_enabled($"Enf-cap", false)
	else:
		$"Enf-cap".show()
		_set_physics_enabled($"Enf-cap", true)

func _set_physics_enabled(node: Node, enabled: bool):
	# If they’re CharacterBody2D or RigidBody2D
	if node is CharacterBody2D or node is RigidBody2D:
		node.set_physics_process(enabled)

	# If they have a CollisionShape2D child
	var shape = node.get_node_or_null("CollisionShape2D")
	if shape:
		shape.disabled = !enabled
