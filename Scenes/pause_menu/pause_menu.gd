extends Control

const MAIN_MENU_PATH := "res://Scenes/main_menu/main_menu.tscn"

@export var main_menu_scene: PackedScene
@export var continuar_button: Button
@export var reiniciar_button: Button
@export var menu_principal_button: Button
@export var escena_principal: Node2D


func _ready() -> void:
	if main_menu_scene == null:
		main_menu_scene = load(MAIN_MENU_PATH)
	if escena_principal == null:
		escena_principal = get_node_or_null("../..")
	continuar_button.pressed.connect(_on_continuar_pressed)
	reiniciar_button.pressed.connect(_on_reiniciar_pressed)
	menu_principal_button.pressed.connect(_on_menu_principal_pressed)


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and visible:
		continuar_button.grab_focus()


func _unpause() -> void:
	get_tree().paused = false
	visible = false


func _on_continuar_pressed() -> void:
	_unpause()


func _on_reiniciar_pressed() -> void:
	_unpause()
	escena_principal._reload_level()


func _on_menu_principal_pressed() -> void:
	_unpause()
	get_tree().change_scene_to_packed(main_menu_scene)