extends Node2D

var faction: String
var stats: Dictionary

func _ready():
    if faction == null:
        faction = "Zombie" # default fallback
    stats = FactionalSpawn.spawn_enemy(faction)
    # set_visual_for_faction(faction)

'''
func set_visual_for_faction(faction: String):
    # Swap sprite based on faction type
    match faction:
        "Zombie":
            $Sprite2D.texture = preload("res://sprites/zombie.png")
        "Bandit":
            $Sprite2D.texture = preload("res://sprites/bandit.png")
        _:
            $Sprite2D.texture = preload("res://sprites/default_enemy.png")

func on_player_collision():
    BattleManager.setup_battle(stats, faction)
    queue_free() # remove from overworld after battle starts
'''