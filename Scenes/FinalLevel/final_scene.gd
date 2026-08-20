extends Control

@onready var _muertes_label: Label = $UILayer/CenterContainer/VBoxContainer/StatsPanel/VBox/MuertesLabel
@onready var _menu_button: Button = $UILayer/CenterContainer/VBoxContainer/MenuButton


func _ready() -> void:
	# Ensure crisp text filtering even if inherited
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	_populate_stats()
	if _menu_button:
		_menu_button.pressed.connect(_on_menu_pressed)


func _populate_stats() -> void:
	var deaths: int = 0
	var gc = get_node_or_null("/root/GlobalController")
	if gc == null and get_tree() and get_tree().root and get_tree().root.has_node("GlobalController"):
		gc = get_tree().root.get_node("GlobalController")
	if gc:
		deaths = gc.death_count
	if _muertes_label:
		_muertes_label.text = "Muertes: %d" % deaths


func _on_menu_pressed() -> void:
	var gc2 = get_node_or_null("/root/GlobalController")
	if gc2 == null and get_tree() and get_tree().root and get_tree().root.has_node("GlobalController"):
		gc2 = get_tree().root.get_node("GlobalController")
	if gc2:
		gc2.level = 1
	get_tree().change_scene_to_file("res://Scenes/main_menu/main_menu.tscn")
