extends Node

var factiondems = {
	"Zombie": {
		"hp_r": Vector2(50, 80),
		"mp_r": Vector2(10, 25),
		"speed_r": Vector2(0.2, 0.5)
	}
}

func spawn_enemy(faction: String) -> Dictionary:
	if not factiondems.has(faction):
		push_error("Faction not defined: %s" % faction)
		return {}

	var base = factiondems[faction]
	var enemy = {
		"name": faction,
		"hp": randi_range(base.hp_r.x, base.hp_r.y),
		"mp": randi_range(base.mp_r.x, base.mp_r.y),
		"speed": randf_range(base.speed_r.x, base.speed_r.y),
		"status_effects": [],
		"moveset": get_moves_for_faction(faction)
	}
	return enemy

func get_moves_for_faction(faction: String) -> Array:
	var valid_moves: Array = []
	for move_name in Moves.moves.keys():
		var move = Moves.moves[move_name]
		var allowed = move["factions"]

		# If factions is null → available to all
		if allowed == null:
			valid_moves.append(move_name)
		# If factions is a String → match directly
		elif typeof(allowed) == TYPE_STRING and allowed == faction:
			valid_moves.append(move_name)
		# If factions is an Array → check membership
		elif typeof(allowed) == TYPE_ARRAY and faction in allowed:
			valid_moves.append(move_name)
	
	# Randomize from the valid moves
	valid_moves.shuffle()

	var count = min(4, valid_moves.size())
	return valid_moves.slice(0, count)
