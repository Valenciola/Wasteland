extends Area2D

var player_inside = false
var box
var flags

func _ready():
	box = get_tree().root.get_node_or_null("Main/Dialogue/DialogueBox")
	flags = GameState.flags
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	if box:
		box.dialogue_finished.connect(_on_dialogue_finished)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		player_inside = true
		print("Player entered rebel battle trigger")

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		player_inside = false
		print("Player left rebel battle trigger")

func _process(delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		print("Interact pressed, starting rebel dialogue")
		_start_dialogue()

func _start_dialogue() -> void:
	if box and (!flags["fought_enf"] and flags["got_reb_materials"]):
		box.show_dialogue([
			["Rebel", "So, you've come snooping around our base…"],
			["[Player]", "I'm here to find out what's going on..."],
			["Rebel", "We take what was stolen from us!"],
			["Rebel", "And if you have a problem with that, then we'll settle this now..."]
		])

func _on_dialogue_finished() -> void:
	if !flags["fought_enf"] and flags["got_reb_materials"]:
		print("Dialogue finished, starting rebel battle")
		BattleManager.set_battle([
			{"name": "Rebel", "hp": 30, "max_hp": 30, "mp": 10, "max_mp": 10, "speed": 5, "moveset": ["Punch", "Kick"]},
			{"name": "Rebel", "hp": 25, "max_hp": 25, "mp": 10, "max_mp": 10, "speed": 4, "moveset": ["Punch"]}]
			)
