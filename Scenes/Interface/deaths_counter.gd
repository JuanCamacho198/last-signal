extends Control
# Deprecated: replaced by coin_tracker.gd (Monedas X/Y HUD).
# Kept for rollback; not instantiated in escena_principal.tscn.
# GlobalController.death_count remains but is no longer displayed.

@export var label: Label

func _ready() -> void:
	GlobalController.death_count_changed.connect(_current_text)
	_current_text()

func _current_text():
	label.text = str(GlobalController.death_count)
