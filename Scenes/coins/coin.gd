extends Node2D

@export var area_2d: Area2D
@export var coin_sound: AudioStreamPlayer2D

var container_coins: ContainerCoins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_picked)
	_init_animation()

func _picked(_body) -> void:
	if container_coins == null:
		return
	container_coins.collect_coin()
	GlobalController.add_score(10)
	_spawn_floating("+10", Color(1, 0.835294, 0.309804, 1), 18)
	coin_sound.reparent(get_parent())
	coin_sound.play()
	queue_free()

func _spawn_floating(text: String, color: Color, font_size: int = 18) -> void:
	var label := Label.new()
	label.text = text
	label.z_index = 100
	label.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 1))
	label.add_theme_constant_override("outline_size", 3)
	label.add_theme_constant_override("shadow_offset_x", 2)
	label.add_theme_constant_override("shadow_offset_y", 2)
	var root = get_tree().current_scene
	if root == null:
		root = get_parent()
	# Ensure label is added to a CanvasItem that renders in screen space
	root.add_child(label)
	label.global_position = global_position + Vector2(-10, -16)
	var tween := label.create_tween()
	tween.set_parallel(true)
	tween.tween_property(label, "position:y", label.position.y - 36, 0.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "modulate:a", 0.0, 0.7)
	tween.chain().tween_callback(label.queue_free)

func _init_animation():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y - 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
