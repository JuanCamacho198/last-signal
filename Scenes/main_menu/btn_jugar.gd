extends Button

@export var main_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_jugar, 4)

func _jugar() -> void:
	get_tree().change_scene_to_packed(main_scene)
