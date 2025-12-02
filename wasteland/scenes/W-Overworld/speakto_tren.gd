extends Area2D

var box

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	box.dialogue_finished.connect(_on_dialogue_finished)

func _on_body_entered(body):
	if !GameState.flags["met_tren"]:
		get_node("../Tren").flip_h = false
		get_tree().root.get_node("Main/Dialogue/DialogueBox").show_dialogue(Lines.travellingengineer)
		GameState.flags["met_tren"] = true


func _on_dialogue_finished():
	if !GameState.flags["got_tren"]:
		GameState.party_members.append("Tren")
		GameState.flags["got_tren"] = true
		get_node("../Tren").visible = false