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
	},

	"Proof": {
		"name": "Sharp Document",
		"description": "A brief document detailing the conditions of the mines.",
		"type": "quest",
		"discardable": false
	},
	"Wood": {
		"name": "Wood",
		"description": "A large stack of wood. You wonder where it came from, considering you haven't seen any trees.",
		"type": "quest",
		"discardable": false
	},
	"Nails": {
		"name": "Nails",
		"description": "A half-empty box of nails. They all seem to be in great condition.",
		"type": "quest",
		"discardable": false
	},
	"Coal": {
		"name": "Coal",
		"description": "A small pile of coal. It stains your hands black.",
		"type": "quest",
		"discardable": false
	},
	"Matches": {
		"name": "Matches",
		"description": "A box of matches. A few of them have snapped in half. You're not quite sure what the use is for these...",
		"type": "quest",
		"discardable": false
	},
	"Plans": {
		"name": "Lengthy Document",
		"description": "A brief document with the words \'coup\' and \'usurp\' written in the midst of it. That doesn't sound good...",
		"type": "quest",
		"discardable": false
	},
	"Hammer": {
		"name": "Hammer",
		"description": "A metal tool you recall was used for construction. Considering the structure of everything around you, it's a bit unclear what purpose this serves right now...",
		"type": "quest",
		"discardable": false
	}
}