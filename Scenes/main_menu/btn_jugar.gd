extends Button

@export var main_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(jugar, 4)

func jugar() -> void:
	var gc = get_node_or_null("/root/GlobalController")
	if gc == null and get_tree() and get_tree().root and get_tree().root.has_node("GlobalController"):
		gc = get_tree().root.get_node("GlobalController")
	if gc:
		if gc.has_method("reset_score"):
			gc.reset_score()
		# reset deaths for a fresh run
		gc.death_count = 0
		gc.level = 1
	get_tree().change_scene_to_packed(main_scene)
