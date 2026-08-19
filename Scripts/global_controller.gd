extends Node

signal death_count_changed(new_count: int)


var death_count: int 
var level: int


func _plus_death_count() -> void:
	death_count += 1
	death_count_changed.emit()