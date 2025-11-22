extends Button

@onready var pic = $TextureRect
@onready var quantity = $Label

# preload your null icon once at the top
var null_icon = preload("res://assets/icons/Null.png")

func setup(item_id: String, count: int):
	var item_data = Items.items[item_id]

	var tex = null_icon
	if item_data.has("icon"):
		if typeof(item_data["icon"]) == TYPE_STRING:
			var loaded = load(item_data["icon"])
			if loaded: 
				tex = loaded
		else:
			tex = item_data["icon"]  # already a Texture2D if you used preload()

	pic.texture = tex
	quantity.text = "x" + str(count)
