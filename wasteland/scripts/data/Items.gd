extends Node

var items = {
	"Apple": {
		"name": "Apple",
		"description": "A common fruit that seems to have withstood the test of time. Miraculously, it seems unspoiled.",
		"type": "consumable",
		"effect": "heal",
		"degree": 25,
		"discardable": true,
		"icon": "res://assets/icons/Apple.png"
	},
	"Water": {
		"name": "Water",
		"description": "A small bottle filled with clear water. The label on it reads, \"Locally Sourced\". That could be a good or bad thing...",
		"type": "consumable",
		"effect": "replenish",
		"degree": 15,
		"discardable": true
	},

	"TrainWheel": {
		"name": "Old Wheel",
		"description": "An old, round piece of metal. It looks like it was in use for something else before, but perhaps it could fit in another vehicle.",
		"type": "quest",
		"discardable": false
	},
	"TrainLight" : {
		"name": "Shiny Lightbulb",
		"description": "A round, shiny lightbulb. It looks brand new! Perfect for lighting the way.",
		"type": "quest",
		"discardable": false
	},
	"TrainGas" : {
		"name": "Gas Tank",
		"description": "A small, portable container of gas. Its scent burns your nose. The label on it reads \"Diesel\".",
		"type": "quest",
		"discardable": false
	}
}