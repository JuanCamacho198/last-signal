extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished.connect(_delete)
	pass # Replace with function body.

func _delete():
	queue_free()
	