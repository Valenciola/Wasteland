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
		# "moveset": base.moveset
	}
	return enemy
