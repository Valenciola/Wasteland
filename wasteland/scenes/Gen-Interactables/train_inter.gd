extends Area2D

var box

func _ready():
	box = get_tree().root.get_node("Main/Dialogue/DialogueBox")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if overlaps_body(get_tree().root.get_node("Player")):
			_on_interact()

func _on_interact():
	if GameState.flags["tren_fixed_train"] and !GameState.flags["player_fixed_train"]:
		# Flash effect + vines disappear + train restored
		await ScreenFX.res_in(2.0)
		get_tree().root.get_node("Main/CurrentMap/W-train-station/Train/TextureRect").texture = preload("res://assets/models/interactables/Train-Restored.png")
		get_tree().root.get_node("Main/CurrentMap/W-train-station/TileMapLayer").visible = false
		get_tree().root.get_node("Main/CurrentMap/W-train-station/TileMapLayer(Reso)").visible = true
		# get_tree().root.print_tree_pretty()

		GameState.flags["player_fixed_train"] = true
		await get_tree().create_timer(0.4).timeout
		await ScreenFX.res_out(2.0)

		box.show_dialogue([
			["???", "You of the Enriched… Bridge these lands…"],
			["???", "Transport your will… Restore the world."],
			["Tren", "[Player]!"],
			["[Player]", "Huh? Oh… What happened?"],
			["Tren", "You just zoned out there for a second. Are you okay?"],
			["[Player]", "I'm fine… but you really didn't hear that strange voice?"],
			["Tren", "I didn't hear anything… But you know what's really strange? That crazy thing you just did! What was that, anyway?"],
			["[Player]", "I don't know… it's as if the train… or rather, the space around the train… was calling out to me…"],
			["Tren", "Right… Well, I guess it's an Enriched thing? I'm sure you're one of those now, after this whole thing."],
			["[Player]", "Hmm…"],
			["Tren", "Anyway, now we can get to Utopia territory!"],
			["[Player]", "Oh… right."],
			["Tren", "I'm not sure if you're hesitating now or if you're just trying to wrap your head around whatever you just did… but either way, take your time. We can get going whenever you're ready!"],
			["[Player]", "Alright…"]
		], false)
