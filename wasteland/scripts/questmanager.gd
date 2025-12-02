extends Node

var quests = {}
var flags = {}

func start_quest(id):
	if quests.has(id):
		quests[id]["started"] = true
		print("Quest started:", quests[id]["name"])

func complete_objective(quest_id, objective_id):
	if quests.has(quest_id):
		for obj in quests[quest_id]["objectives"]:
			if obj["id"] == objective_id:
				obj["completed"] = true
				print("Objective complete:", obj["description"])
		check_quest_completion(quest_id)

func check_quest_completion(quest_id):
	if quests.has(quest_id):
		for obj in quests[quest_id]["objectives"]:
			if not obj["completed"]:
				return false
		quests[quest_id]["completed"] = true
		print("Quest complete:", quests[quest_id]["name"])
		return true
	return false
