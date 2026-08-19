class_name ControllerGame
extends Node

@export var game_data: GameData

var _route: String = "user://game.tres"

func _save_game_data() -> void:
    game_data.level = GlobalController.level
    game_data.death_count = GlobalController.death_count

    ResourceSaver.save(game_data, _route)

func _load_game_data() -> void:
    if ResourceLoader.exists(_route):
        game_data = load(_route)

        GlobalController.level = game_data.level
        GlobalController.death_count = game_data.death_count
    else:
        GlobalController.level = 1
        GlobalController.death_count = 0
