extends Node2D

@export var nivels: Array[PackedScene]

var _current_level: int = 1
var _current_level_instance: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_level(_current_level)

func _create_level(level: int) -> void:
	_current_level_instance = nivels[level - 1].instantiate()
	add_child(_current_level_instance)
	
	var children := _current_level_instance.get_children()
	for i in children.size():
		if children[i].is_in_group("characters"):
			children[i].character_dead.connect(_reload_level)
			break

func _destroy_level() -> void:
	_current_level_instance.queue_free()

func _reload_level() -> void:
	_destroy_level()
	_create_level.call_deferred(_current_level)

func next_level():
	_current_level += 1
	_destroy_level()
	_create_level.call_deferred(_current_level)
