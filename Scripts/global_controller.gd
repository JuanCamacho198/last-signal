extends Node

signal death_count_changed(new_count: int)
signal coins_total_changed(total: int)
signal coins_collected_changed(collected: int, total: int)
signal score_changed(new_score: int)

var death_count: int
var level: int
var coins_total: int = 0
var coins_collected: int = 0
var score: int = 0


func _plus_death_count() -> void:
	death_count += 1
	death_count_changed.emit(death_count)

func reset_coins() -> void:
	coins_total = 0
	coins_collected = 0
	coins_total_changed.emit(0)
	coins_collected_changed.emit(0, 0)
	# score persists across levels - do NOT reset here (final needs it)

func reset_score() -> void:
	score = 0
	score_changed.emit(score)

func add_score(p: int) -> void:
	score += p
	score_changed.emit(score)

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
