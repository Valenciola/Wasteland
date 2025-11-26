extends Node

var moves = {
	# Overall Moves
	"Punch": {
		"name": "Punch", # The actual name of the move
		"description": "A deft, hard swing.", # A short description of the move
		"type": "attack", # Meant to cause damage, heal, boon, etc...
		"target": "enemy", # Area effect, singular target effect (enemy/team), or self inflict
		"power": 15, # The degree; what it effects is dependent on the type
		"factions": null, # Factions the move is available to; null = all
		"cost": 1, # The amount of MP it uses
		"effect": null, # Effects to be applied to the target if necessary,
		"chance": 0 # The chance of the effect being applied
	},
	"Kick": {
		"name": "Kick",
		"description": "A simple, swift kick.",
		"type": "attack",
		"target": "enemy",
		"power": 10,
		"factions": null,
		"cost": 8,
		"effect": {
			"status": "speed",
			"duration": 3,
			"degree": -0.2
		},
		"chance": 0.4
	},

	# Faction-Specific
	"Shift": {
		"name": "Shift",
		"description": "Release a wave of a mysterious power.",
		"type": "attack",
		"target": "enemy",
		"power": 20,
		"factions": ["Enriched"],
		"cost": 10,
		"effect": null,
		"chance": null
	},
	"Bite": {
		"name": "Bite",
		"description": "A painful, stinging bite",
		"type": "attack",
		"target": "enemy",
		"power": 10,
		"factions": ["Zombie"],
		"cost": 5,
		"effect": null,
		"chance": null
	},

	# Ability-Specific
	"MetalMark": {
		"name": "Metal Mark",
		"description": "Hand it to your enemies with a piece of metal to the side.",
		"type": "attack",
		"target": "enemy",
		"power": 20,
		"factions": ["Utopia", "Woodtown"],
		"cost": 5,
		"effect": null,
		"chance": null
	}
}