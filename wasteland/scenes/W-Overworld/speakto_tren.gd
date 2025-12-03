extends Area2D

var box

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")
	box.dialogue_finished.connect(_on_dialogue_finished)

func _process(delta):
	# Allow pressing E to interact with Tren after intro
	if GameState.flags["met_tren"] and Input.is_action_just_pressed("interact"):
		if overlaps_body(get_tree().root.get_node("Player")):
			_on_interact()

func _on_body_entered(body):
	if !GameState.flags["met_tren"]:
		get_node("../Tren").flip_h = false
		box.show_dialogue(Lines.travellingengineer)
		GameState.flags["met_tren"] = true

func _on_dialogue_finished():
	if !GameState.flags["got_tren"]:
		GameState.party_members.append("Tren")
		GameState.flags["got_tren"] = true

		# If player already has all parts at intro
		if GameState.inventory.has("TrainWheel") \
		and GameState.inventory.has("TrainLight") \
		and GameState.inventory.has("TrainGas") \
		and "Tren" in GameState.party_members:
			GameState.flags["got_parts"] = true
			box.show_dialogue([
				["Tren", "Wait, you have everything already? Huh..."],
				["Tren", "Well, I guess I'll take those off your hands..."]
			], false)

func _on_interact():
	# Later interaction: check inventory again
	if GameState.inventory.has("TrainWheel") \
	and GameState.inventory.has("TrainLight") \
	and GameState.inventory.has("TrainGas") \
	and "Tren" in GameState.party_members \
	and GameState.flags["got_parts"]:

		# Fade to black → Tren repairs → dialogue while black → fade back in → train still stuck
		await ScreenFX.fade_in(2.0)

		box.show_dialogue([
			["Tren", "Just place that there, and…"],
			["Tren", "Done! The train should be all good now!"]
		], false)

		await box.dialogue_finished

		await ScreenFX.fade_out(2.0)

		box.show_dialogue([
			["[Player]", "Is something supposed to happen?"],
			["Tren", "Yes… But I'm not sure what I'm missing. Everything's in the right place…"],
			["???", "You of the Enriched… Restore the world."],
			["[Player]", "Tren, did you hear that?"],
			["Tren", "Hear what?"],
			["[Player]", "What…? Um…"],
			["[Player]", "Never mind. Let me have a look…"]
		])

		GameState.flags["tren_fixed_train"] = true
