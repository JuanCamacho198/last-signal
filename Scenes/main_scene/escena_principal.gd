extends Node2D

@export var nivels: Array[PackedScene]
@export var controller_game: ControllerGame

var _current_level: int = 1
var _current_level_instance: Node

@onready var _banner: Control = $CanvasLayer/LevelBanner
@onready var _banner_label: Label = $CanvasLayer/LevelBanner/Label
@onready var _banner_timer: Timer = $CanvasLayer/LevelBanner/Timer
@onready var _coin_tracker: Control = $CanvasLayer/CoinTracker

var _coins_connected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not _coins_connected:
		GlobalController.coins_collected_changed.connect(_on_coins)
		_coins_connected = true
	if _banner_timer:
		_banner_timer.timeout.connect(_on_banner_timeout)
	if GlobalController.level > 1:
		_load_level()
	else:
		_create_level(_current_level)


func _create_level(level: int) -> void:
	GlobalController.reset_coins()
	_current_level = level
	_current_level_instance = nivels[level - 1].instantiate()
	add_child(_current_level_instance)
	
	var children := _current_level_instance.get_children()
	for i in children.size():
		if children[i].is_in_group("characters"):
			children[i].character_dead.connect(_reload_level)
			break
	
	GlobalController.level = level
	controller_game._save_game_data()
	_show_banner(level)

func _destroy_level() -> void:
	if _current_level_instance:
		_current_level_instance.queue_free()

func _reload_level() -> void:
	_destroy_level()
	_create_level.call_deferred(_current_level)

func next_level():
	if _current_level >= nivels.size():
		# At final level, do not advance beyond
		return
	_current_level += 1
	_destroy_level()
	_create_level.call_deferred(_current_level)

func _load_level():
	_current_level = GlobalController.level
	_create_level.call_deferred(_current_level)

func _show_banner(level: int) -> void:
	if not _banner or not _banner_label or not _banner_timer:
		return
	# FinalScene tiene su propia pantalla - no mostrar banner ni HUD naranja allí
	if level == nivels.size():
		_banner.visible = false
		if _coin_tracker:
			_coin_tracker.visible = false
		return
	if _coin_tracker:
		_coin_tracker.visible = true
	_banner_label.text = "Nivel %d" % level
	_banner.visible = true
	_banner_timer.start(2.0)

func _on_banner_timeout() -> void:
	if _banner:
		_banner.visible = false

func _on_coins(c: int, t: int) -> void:
	if t > 0 and c >= t:
		next_level()
