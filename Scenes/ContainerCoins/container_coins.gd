class_name ContainerCoins
extends Node

signal all_coins_collected

var _total_coins: int 
var _coins_collected: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var coins := get_children()
	_total_coins = coins.size()

	for coin in coins:
		coin.container_coins = self

func collect_coin() -> void:
	_coins_collected += 1
	if _coins_collected >= _total_coins:
		all_coins_collected.emit()

	if _coins_collected == _total_coins:
		get_parent().get_parent().next_level()


