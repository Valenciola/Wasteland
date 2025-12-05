extends Area2D

var player_inside = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		# autorun immediately when player enters
		print("Player entered Valen trigger")
		_start_dialogue()

func _start_dialogue():
	var box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	if box and !GameState.flags["met_utopian_leader"]:
		box.show_dialogue(Lines.valen_intro, false)
		GameState.party_members.append("Arihara")
		GameState.flags["met_utopian_leader"] = true