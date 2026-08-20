class_name ContainerCoins
extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var coins := get_children()
	for coin in coins:
		coin.container_coins = self
	GlobalController.set_coins_total(coins.size())

func collect_coin() -> void:
	GlobalController.collect_coin()
