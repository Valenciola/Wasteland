extends Node2D

var contenders = {}
var turn_order = []

var movedict = Moves.moves

func set_battle(enemy_node: Node):
	contenders.clear()

	# Loop through each party member name in current_stats
	for member in GameState.party_members:
		var stats = GameState.base_stats[member].duplicate()
		stats["hp"] = GameState.current_stats[member]["hp"]
		stats["mp"] = GameState.current_stats[member]["mp"]

		contenders[member] = stats

	# Add the enemy
	contenders[enemy_node.name] = enemy_node.stats

	print("Contenders:", contenders)

	det_order()

	# TODO: change scene to battle (start battle, effectively)

func det_order():
	var temp = []

	for cont in contenders.keys():
		temp.append({"name": cont, "stats": contenders[cont]})
	
	temp.sort_custom(Callable(self, "_sort_by_speed"))

	turn_order.clear()
	for entry in temp:
		turn_order.append(entry["name"])
	
	turn_order.reverse()

	print(turn_order)

func _sort_by_speed(a, b):
	return b["stats"]["speed"] - a["stats"]["speed"]
