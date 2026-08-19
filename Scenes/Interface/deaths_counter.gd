extends Control

@export var label: Label

func _ready() -> void:
	GlobalController.death_count_changed.connect(_current_text)

func _current_text():
	label.text = str(GlobalController.death_count)