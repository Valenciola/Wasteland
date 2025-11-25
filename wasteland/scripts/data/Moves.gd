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
		"abilities": null, # Abilities the move is available to; null = all
		"cost": 5, # The amount of MP it uses
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
		"abilities": null,
		"cost": 8,
		"effect": {
			"status": "speed",
			"duration": 3,
			"degree": -0.2
		},
		"chance": 0.4
	}
}