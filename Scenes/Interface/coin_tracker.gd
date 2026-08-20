extends Control

@export var label: Label

func _ready() -> void:
	GlobalController.coins_total_changed.connect(_on_total)
	GlobalController.coins_collected_changed.connect(_on_collected)
	GlobalController.score_changed.connect(_on_score)
	_update(GlobalController.coins_collected, GlobalController.coins_total)
	_update_score(GlobalController.score)

func _on_total(t: int) -> void:
	_update(GlobalController.coins_collected, t)

func _on_collected(c: int, t: int) -> void:
	_update(c, t)

func _on_score(s: int) -> void:
	_update_score(s)

func _update(c: int, t: int) -> void:
	var has_coins := t > 0
	var has_score := GlobalController.score > 0
	visible = has_coins or has_score
	if not visible:
		return
	if has_coins and has_score:
		label.text = "Monedas %d/%d | Puntos %d" % [c, t, GlobalController.score]
	elif has_coins:
		label.text = "Monedas %d/%d" % [c, t]
	else:
		label.text = "Puntos %d" % GlobalController.score

func _update_score(_s: int) -> void:
	_update(GlobalController.coins_collected, GlobalController.coins_total)
