extends Node2D

@export var area_2d: Area2D
@export var points: int = 50
@export var coin_sound: AudioStreamPlayer2D

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
	if coin_sound:
		coin_sound.reparent(get_parent())
		coin_sound.play()
	queue_free()

func _init_animation():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y - 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
