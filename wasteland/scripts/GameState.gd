extends Node

# Overarching settings (#1)
var player_name = "You"

var player_stats = {
    "max_hp": 100,
    "max_mp": 50,
    "speed": 0.4
}

var inventory = [] # Inventory contents persist across scenes, think Industrial Dungeon
var flags = {}
var active_quests = {} # Quests persist throughout scenes
var party_members = [] # Party members persist as well

var settings = {} # Dictionary will store overarching setting data

var next_spawn_point : String = "" # The place where the player should spawn next

func _ready():
    print("GameState is all good!")