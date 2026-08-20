extends Control

@export var label: Label

func _ready() -> void:
	GlobalController.coins_total_changed.connect(_on_total)
	GlobalController.coins_collected_changed.connect(_on_collected)
	_update(GlobalController.coins_collected, GlobalController.coins_total)

func _on_total(t: int) -> void:
	_update(GlobalController.coins_collected, t)

func _on_collected(c: int, t: int) -> void:
	_update(c, t)

func _update(c: int, t: int) -> void:
	visible = t > 0
	if visible:
		label.text = "Monedas %d/%d" % [c, t]
