extends Node

# Cutscene 1 - Your Mission
var yourmission1 = [
	["???", "… \n\n\n[Press enter to continue.]"],
	["???", "Hear me… You of the Enriched…"],
	["???", "If to waste not is to want not… Did we ever truly wish to live?"],
	["???", "Dangerous ambition… dangerous passivity…"],
	["???", "Search for meaning in the abstract… Listen, you who bears this…"],
	["???", "Gift or burden, save or sacrifice…"],
	["???", "Heed this call."],
	["???", "Restore the world."]
]

var yourmission2 = [
	["[Player]", "Nngh…"],
	["[Player]", "What's… going on? Where… am I?"],
	["[Player]", "Was someone talking to me just now? But… I don't see anyone here…"],
	["[Player]", "I didn't understand much of what the person was talking about, anyway… Restore the world? What does that mean?"],
	["[Player]", "Maybe… I should try to find whoever it is. Then I can ask."],
	["TIP", "Use the arrow keys to explore. You can interact with items by pressing \'E\'."]
]

# Custcene 2 - A Surprise Encounter
var surpriseencounter1 = [
	["[Player]", "Hmm…"],
	["[Player]", "If there was no one here, then…?"],
	["[Player]", "Who was speaking to me before I ended up here…?"]
]

var surpriseencounter2 = [
	["Zombie", "GRAHHHHH!"],
	["[Player]", "!!!"],
	["[Player]", "Wha… WHAT IS THAT?!"],
	["Zombie", "GRAWWRRRR!!!"],
	["[Player]", "GYAHHH!!!"]
]

# Cutscene 3 - The Travelling Engineer
var travellingengineer = [
	["???", "…"],
	["[Player]", "…"],
	["[Player]", "Um… hello?"],
	["???", "!"],
	["???", "Oh… it's just a kid…"],
	["[Player]", "Um, I think I'm a bit older than a kid…"],
	["[Player]", "(This guy's voice doesn't sound like the one that called me…)"],
	["???", "Right, right…"],
	["???", "Sorry, I know this is a bit awkward… but I really wasn't expecting to find anyone here. What are you doing here, anyway?"],
	["[Player]", "I… uh… I could ask you the same question."],
	["???", "Are you from here?"],
	["[Player]", "Are you?"],
	["???", "…"],
	["???", "You sure ask a lot of questions, but don't give a lot of answers…"],
	["[Player]", "I… I just have one more! Who are you?"],
	["Tren", "They call me Tren. I used to work on trains… you know… before this whole thing happened."],
	["[Player]", "What whole thing?"],
	["Tren", "…You really don't know?"],
	["[Player]", "…"],
	["[Player]", "Actually, I don't know much of anything. I mean, I can hardly remember anything… I just woke up here… Oh, but I heard someone calling to me asking me to restore the world and I also discovered these weird things I can do…"],
	["Tren", "Okay okay one thing at a time. How about I start with a simple question: who are you?"],
	["[Player]", "My name's [Player]."],
	["Tren", "Got it, [Player]... So you say there's weird things you could do, huh?"],
	["Tren", "(I wonder if this kid is…?)"],
	["[Player]", "Yeah! Um… have you ever heard of people doing, uh… magic? But like, it's real, not just a trick?"],
	["Tren", "Yeah, I have, actually… ever heard of the Enriched?"],
	["[Player]", "No…"],
	["[Player]", "(I thought I just told him I can't remember…)"],
	["Tren", "Well, to keep it short…"],
	["Tren", "Basically, this area used to be a material-rich deposit, and there were a lot of operations underway to extract all of it, but then…"],
	["Tren", "A tragedy occurred. This strange virus started infecting people and changing them in strange ways… At the same time, the land here began to cave under all the stress from extraction… and that's why it looks like that outside now. They say the virus originated from the Earth. It's all very curious…"],
	["[Player]", "You said the virus can change people? Can it turn them into monsters…?"],
	["Tren", "Oh, you must be talking about the zombies. Yeah, those would be people who got infected and succumbed, but didn't die. But then there's also people who survived, though they were also changed. It's said that some people developed special powers after surviving… and they call them the Enriched."],
	["[Player]", "The Enriched, huh…? So you think I'm one of those… except… I don't remember ever suffering any virus… Also did everyone who survived it become like me?"],
	["Tren", "No, there are some who just underwent subtle physiological changes but didn't develop any powers. They call them the Unriched."],
	["[Player]", "So you're an Unriched?"],
	["Tren", "No, I'm a regular human. Most of the Unriched live in Utopia territory. I'm not from here or there, and the virus didn't spread to other areas. I'm a traveller!"],
	["[Player]", "(Is it really safe to be travelling right now?)"],
	["[Player]", "Okay, well, why did you come here?"],
	["Tren", "I was kinda trying to investigate the effects of the tragedy and see if there was any evidence pointing to how this really happened… but it seems instead I found you… And this train over here."],
	["[Player]", "That's a train?"],
	["Tren", "If I've ever seen one! If I can repair it, it'll make getting around a lot easier…"],
	["[Player]", "Can't you?"],
	["Tren", "I'm missing a few important parts that I need to fix it… but I'm sure they're around here somewhere…"],
	["[Player]", "(Hmm… he mentioned another territory where other people who survived the virus are? Maybe it would be good for me to go there instead of hanging around this strange ghost town…)"],
	["[Player]", "Let me help you. I'll find the parts so you can fix this thing… but only if you'll take me to this Utopia territory you mentioned!"],
	["Tren", "Really? I guess I was planning to head there anyway… But… How about I accompany you?"],
	["[Player]", "Why?"],
	["Tren", "Well, for one thing, you're definitely still a kid… and you said you can't remember anything about yourself, other than your name, of course. What kind of person would I be if I let an amnesic kid hang around here alone? Especially with zombies running around?"],
	["[Player]", "For your information, I think I was doing just fine before I ran into you… but… Alright."],
	["[Player]", "(Besides, I don't know how long I'll last on my own… and Tren seems to know what he's talking about. I'm not sure I have any other option but to trust him…)"],
	["Tren", "Great! Sounds like you've got a deal, [Player]. Let's look around and see if we can find what we need! I'll help you out with the zombies, too."],
	["[Player]", "Okay. Thanks, Tren."]
]

# Repair the Train
