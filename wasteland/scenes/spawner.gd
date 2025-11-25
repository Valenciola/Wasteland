extends Node2D

var EnemyScene = preload("res://scenes/Sprites/Enemy.tscn")

func _ready():
	var current_map = get_node("../CurrentMap").get_child(0) # first child is Wasteland-ext
	var map_name = current_map.name
	create_enemy_for_map(map_name)

func create_enemy_for_map(map_name: String):
	var spawn_points = []
	var faction = ""

	match map_name:
		"Wasteland-ext":
			# zombies only spawn in wasteland
			spawn_points = [
				Vector2(200, 150),
				Vector2(400, 300),
				Vector2(600, 450)
			]
			faction = "Zombie"

		_:
			print("No spawn rules for map:", map_name)
			return

	# spawn enemies at allowed points
	for point in spawn_points:
		var enemy = EnemyScene.instantiate()
		enemy.faction = faction
		add_child(enemy)
		enemy.position = point
		print("Spawned %s at %s in %s" % [faction, point, map_name])
