extends Node

@export var pause_menu: Control


func _ready() -> void:
	if pause_menu == null:
		pause_menu = get_parent().get_node_or_null("CanvasLayer/PauseMenu")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused