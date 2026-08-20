extends Node

signal death_count_changed(new_count: int)
signal coins_total_changed(total: int)
signal coins_collected_changed(collected: int, total: int)

var death_count: int
var level: int
var coins_total: int = 0
var coins_collected: int = 0


func _plus_death_count() -> void:
	death_count += 1
	death_count_changed.emit(death_count)

func reset_coins() -> void:
	coins_total = 0
	coins_collected = 0
	coins_total_changed.emit(0)
	coins_collected_changed.emit(0, 0)

func set_coins_total(t: int) -> void:
	coins_total = t
	coins_collected = 0
	coins_total_changed.emit(t)
	coins_collected_changed.emit(0, t)

func collect_coin() -> void:
	if coins_total == 0:
		return
	if coins_collected >= coins_total:
		return
	coins_collected += 1
	coins_collected_changed.emit(coins_collected, coins_total)
