extends CanvasLayer

@onready var black = $BlackOverlay

func _ready() -> void:
	$BlackOverlay.visible = false
	$BlueOverlay.visible = false

func fade_in(duration: float = 1.0) -> void:
	$BlackOverlay.modulate.a = 0.0
	$BlackOverlay.visible = true
	var tween = create_tween()
	tween.tween_property($BlackOverlay, "modulate:a", 1.0, duration)
	await tween.finished

func fade_out(duration: float = 1.0) -> void:
	$BlackOverlay.modulate.a = 1.0
	$BlackOverlay.visible = true
	var tween = create_tween()
	tween.tween_property($BlackOverlay, "modulate:a", 0.0, duration)
	await tween.finished
	$BlackOverlay.visible = false

func res_in(duration: float = 1.0) -> void:
	$BlueOverlay.modulate.a = 0.0
	$BlueOverlay.visible = true
	var tween = create_tween()
	tween.tween_property($BlueOverlay, "modulate:a", 1.0, duration)
	await tween.finished

func res_out(duration: float = 1.0) -> void:
	$BlueOverlay.modulate.a = 1.0
	$BlueOverlay.visible = true
	var tween = create_tween()
	tween.tween_property($BlueOverlay, "modulate:a", 0.0, duration)
	await tween.finished
	$BlueOverlay.visible = false
