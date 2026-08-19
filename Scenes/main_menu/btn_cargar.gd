extends Button

@export var controller_game: ControllerGame
@export var btn_jugar: Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_load_game, 4)

func _load_game() -> void:
	controller_game._load_game_data()
	btn_jugar.jugar()