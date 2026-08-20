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
	coin_sound.reparent(get_parent())
	coin_sound.play()
	queue_free()

func _init_animation():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y - 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
