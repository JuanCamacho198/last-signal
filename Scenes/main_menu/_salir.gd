extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_salir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _salir() -> void:
	get_tree().quit()