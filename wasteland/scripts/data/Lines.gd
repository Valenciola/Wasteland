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

# Arrive in Utopia
var utrainarrival = [
	["Tren", "Well, here we are. Welcome to what I'm pretty sure is Utopia's train station."],
	["[Player]", "Oh? It's very... clean..."],
	["Tren", "Yeah, well, that's Utopia for you. Well, should we get going?"],
	["[Player]", "What about the train?"],
	["Tren", "I mean, I think it'll be fine here. I doubt anyone actually has the means to do anything like steal it..."],
	["Tren", "(Still, it's got these strange blue marks on it... and it mysteriously looks brand new... But maybe that would weird someone out more than make them want to take it...)"],
	["[Player]", "Tren?"],
	["Tren", "Oh, uh... why don't you go ahead?"],
	["[Player]", "Sure... I won't go too far."]
]

var valen_intro = [
    ["???", "Ah, so you've finally made your way here."],
    ["[Player]", "Oh, uh, sorry… I must've entered the wrong building…"],
    ["???", "Not at all. Please, allow me to introduce myself…"],
    ["Valen", "My name is Valen. I am the leader of this area called Utopia."],
    ["[Player]", "Oh…? Um… can I ask you a question, then?"],
    ["Valen", "…Go ahead."],
    ["[Player]", "What's the deal with this place? How could it possibly be so… not… devastated? Hasn't the world effectively ended?"],
    ["Valen", "Haha! A valid question. I see you must've come from somewhere like Wasteland, right?"],
    ["[Player]", "How did you know?"],
    ["Valen", "Your question made it quite obvious. Yes, I would agree the world has ended… but this place is just the end of the world as we know it."],
    ["[Player]", "Sorry…?"],
    ["Valen", "We represent here a new world order. One free of the mistakes that led to our downfall. Or… that's what we've been going for."],
    ["[Player]", "I see. So why are you telling all this to me?"],
    ["Valen", "Well, you… you're of the Enriched, aren't you?"],
    ["[Player]", "?!?!"],
    ["Valen", "You ought to know that not much happens in this land that evades my attention. One of my subjects saw your train coming in, and we did not miss its unearthly blue shades…"],
    ["[Player]", "Um…"],
    ["Valen", "I know we've just met, but there is a request I'd like to make of you. Would you use your strength to further our desires for peace?"],
    ["[Player]", "M-me? But I don't even know how to use whatever abilities being Enriched gave me, not to mention I hardly know this place…!"],
    ["Valen", "Of course. I will offer you aid. To my left stands one of my servants, Arihara. She will accompany you throughout Utopia. I'd also like to request that you speak to Captain Brody, who is standing to my right."],
    ["Brody", "You can find me at the office to the west. It's a stark, gray building. You can't miss it."],
    ["[Player]", "(Aw man, I haven't even said yes or no yet…)"],
    ["Valen", "Please take your time, and don't feel pressured to abide by my request. Just allow Arihara to guide you for now. However, do recall…"],
    ["Valen", "The events of the future will rely on you."],
    ["[Player]", "Yeah, okay…"]
]

var tren_warning = [
    ["Tren", "…"],
    ["[Player]", "Oh, Tren! There you are…"],
    ["Tren", "…"],
    ["[Player]", "Tren?"],
    ["Tren", "[Player]... did you see the Utopian leader in that hall just now?"],
    ["[Player]", "Oh yeah, I did. Speaking of, this lady next to me… Her name is Arihara, and apparently she's supposed to be our guide."],
    ["Tren", "[Player], listen to me. What did that leader say to you?"],
    ["[Player]", "Oh, uh… something about helping further his peace mission here…"],
    ["Tren", "Right…"],
    ["[Player]", "Tren, what's the matter?"],
    ["Tren", "I just… I was wandering around looking for you and I saw some things that aren't adding up…"],
    ["[Player]", "Like…?"],
    ["Tren", "Well, for one, there seems to be some sort of military force around here. In fact, that might be why there's no one out right now."],
    ["[Player]", "Hmm…?"],
    ["Tren", "I also stumbled upon a mining area to the northwest, and all of the people working there look terrible…"],
    ["[Player]", "What are you trying to say?"],
    ["Tren", "What's this leader's idea of peace? Why do people appear to be suffering? Something just isn't sitting right with me… I think you need to be careful, okay?"],
    ["[Player]", "Okay."]
]