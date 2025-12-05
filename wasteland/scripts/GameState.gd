extends Node

# Player Attributes
var player_name: String
var inventory = {} # Inventory contents persist across scenes, think Industrial Dungeon
var flags = {
	"u-debug": false,

	# Act 1: Waking Up
	"intro": false,
	"house_seen": false,
	"tutorial_done": false,

	# Act 1: Exploration
	"in_red_house": false,
	"open_house_crate": false,
	"battled_zombie": false,
	"beat_zombie": false,

	# Act 1: Meet Tren
	"met_tren": false,
	"got_tren": false,
	"got_parts": false,
	"tren_fixed_train": false,
	"player_fixed_train": false,

	# Act 2: Intro
	"arrived_in_utopia": false,
	"met_utopian_leader": false,
	"tren_warned": false,

	# Path A
	"spoke_to_enf": false,
	"got_reb_materials": false,
	"fought_reb": false,
	"got_rumors": false,
	"reported_rumors": false,
	"final_a": false,

	# Path B
	"spoke_to_miner": false,
	"got_mine_proof": false,
	"fought_enf": false,
	"spoke_coup": false,
	"got_materials": false,
	"final_b": false,

	"help_u": false,
	"expose_u": false
}
var active_quests = {} # Quests persist throughout scenes
var party_members = ["Player"] # Party members persist as well

var current_stats = {
	"Player": {"hp": 100, "mp": 50},
	"Tren": {"hp": 85, "mp": 50},
	"Arihara": {"hp": 90, "mp": 75}
}

# Persistent Stats
var base_stats = {
	"Player": {
		"max_hp": 100,
		"max_mp": 50,
		"speed": 0.4,
		"abilities": ["resonance"],
		"faction": "Enriched",
		"moveset": ["Punch", "Kick", "Shift"]
	},
	"Tren": {
		"max_hp": 85,
		"max_mp": 50,
		"speed": 0.6,
		"abilities": ["mechanic"],
		"faction": "Woodtown",
		"moveset": ["Punch", "Kick", "MetalMark"]
	},
	"Arihara": {
		"max_hp": 90,
		"max_mp": 75,
		"speed": 0.4,
		"abilities": ["citizen"],
		"faction": "Utopia"
	}
}

# Back workings
var settings = {} # Dictionary will store overarching setting data
var player_can_move: bool = true # The way I'm gonna take away player control lol
var next_spawn_point : String = "" # The place where the player should spawn next

# ID-Based Definitions
var crates = {
	"redhouse": {
		"Apple": 3
	},
	"purplehouse_a": {
		"Apple": 2
	},
	"purplehouse_b": {
		"Apple": 3,
		"Water": 1
	},
	"shedsouth": {
		"Water": 1,
		"TrainWheel": 1
	},
	"shedwest": {
		"TrainLight": 1
	},
	"storage-u": {
		"TrainGas": 1
	},

	"mining-office": {
		"Water": 5,
		"Proof": 1
	},
	"reb-west": {
		"Wood": 1,
		"Nails": 1,
		"Coal": 1
	},
	"reb-south": {
		"Matches": 1,
		"Plans": 1
	},
	"enf-res": {
		"Hammer": 1
	}
}

func _ready():
	print("GameState is all good!")
