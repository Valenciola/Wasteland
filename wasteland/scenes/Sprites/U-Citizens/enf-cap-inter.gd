extends Area2D

var box
var flags
var player_inside = false   # track if player is in the area

func _ready() -> void:
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	flags = GameState.flags
	box.dialogue_finished.connect(_on_dialogue_finished)

	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	print("Entered:", body.name)
	if body.name == "Player":
		player_inside = true

func _process(delta):
	if player_inside:
		print("Player inside:", player_inside)
	if Input.is_action_just_pressed("interact"):
		print("Interact detected globally")
	if player_inside and Input.is_action_just_pressed("interact"):
		print("Interact pressed inside area")
		_start_dialogue()

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		player_inside = false

func _start_dialogue() -> void:
	print("Flags at dialogue start:", flags)
	if !flags["spoke_to_enf"] and flags["met_utopian_leader"]:
		box.show_dialogue([
			["Brody", "Oh, there you are."],
			["[Player]", "Yeah, I figured I might as well see what you Valen wanted me to see you about..."],
			["Brody", "Yes, well, if you could look into something for me..."],
			["Brody", "We suspect that there are rebels that have stolen some materials from the enforcer office."],
			["[Player]", "Rebels?"],
			["Brody", "Fools who oppose the order that brings us peace. I'd like you to do some digging and confirm this claim."],
			["[Player]", "Um, are you sure that's okay?"],
			["Brody", "I'm giving you my authority to do so. See me again once you've discovered any evidence, in favor or otherwise."]
		])
	elif flags["spoke_to_enf"] and (GameState.inventory.has("Matches") and GameState.inventory.has("Coal")):
		box.show_dialogue([
			["[Player]", "Captain! I took a look around and I found some coal and matches. Is that what you were missing?"],
			["Brody", "Indeed it was."],
			["Brody", "..."],
			["Brody", "Hmph. Clearly we need to explain our stance to these rebels..."],
			["[Player]", "(What does he mean by that...?)"],
			["Brody", "Thank you. I must call my forces to visit the southern base. You've done enough for me."],
			["[Player]", "The western base...?"]
		])

func _on_dialogue_finished() -> void:
	if !flags["spoke_to_enf"] and flags["met_utopian_leader"]:
		flags["spoke_to_enf"] = true
	elif flags["spoke_to_enf"] and !flags["got_reb_materials"]:
		flags["got_reb_materials"] = true


'''
var box
var flags

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	flags = GameState.flags
	box.dialogue_finished.connect(_on_dialogue_finished)



func _on_dialogue_finished():
	pass
'''
