extends Node2D

@export var area_2d: Area2D
@export var points: int = 50
@export var coin_sound: AudioStreamPlayer2D
@export var boost_duration: float = 7.0

var _collected: bool = false

func _ready() -> void:
	if area_2d:
		area_2d.body_entered.connect(_picked)
	_init_animation()

func _picked(_body) -> void:
	if _collected:
		return
	# Accept any body; optionally filter by player group/layer.
	# If you want strict player-only, uncomment next two lines:
	# if not (_body.is_in_group("characters") or _body.is_in_group("player") or _body.name == "Personaje"):
	# 	return
	_collected = true
	GlobalController.add_score(points)
	_spawn_floating("+%d" % points, Color(0.5, 1.0, 0.8, 1), 20)
	if _body.has_method("apply_energy_boost"):
		_body.apply_energy_boost(boost_duration)
	else:
		var player = get_tree().get_first_node_in_group("characters")
		if player and player.has_method("apply_energy_boost"):
			player.apply_energy_boost(boost_duration)
	if coin_sound:
		coin_sound.reparent(get_parent())
		coin_sound.play()
	queue_free()

func _spawn_floating(text: String, color: Color, font_size: int = 20) -> void:
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
