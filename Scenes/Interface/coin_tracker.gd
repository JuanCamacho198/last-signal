extends Control

@export var label: Label

@onready var _coins_label: Label = get_node_or_null("ColorRect/HBoxContainer/CoinsLabel")
@onready var _sep_label: Label = get_node_or_null("ColorRect/HBoxContainer/SepLabel")
@onready var _points_label: Label = get_node_or_null("ColorRect/HBoxContainer/PointsLabel")
@onready var _legacy_label: Label = get_node_or_null("ColorRect/HBoxContainer/Label")

var _coins_total: int = 0
var _coins_collected: int = 0
var _score: int = 0


func _ready() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	GlobalController.coins_total_changed.connect(_on_total)
	GlobalController.coins_collected_changed.connect(_on_collected)
	GlobalController.score_changed.connect(_on_score)
	_coins_total = GlobalController.coins_total
	_coins_collected = GlobalController.coins_collected
	_score = GlobalController.score
	# Resolve exported legacy label if new structure not yet ready
	if _coins_label == null and label == null:
		label = _legacy_label
	_update_all()


func _on_total(t: int) -> void:
	_coins_total = t
	_update_all()


func _on_collected(c: int, t: int) -> void:
	_coins_collected = c
	_coins_total = t
	_update_all()


func _on_score(s: int) -> void:
	_score = s
	_update_all()


func _update_all() -> void:
	var has_coins := _coins_total > 0
	var has_score := _score > 0
	visible = has_coins or has_score
	if not visible:
		return
	# New integrated HUD: 3 labels inside HBox
	if _coins_label and _points_label and _sep_label:
		_coins_label.text = "%d/%d" % [_coins_collected, _coins_total]
		_points_label.text = "%d pts" % _score
		_coins_label.visible = has_coins
		_points_label.visible = has_score
		_sep_label.visible = has_coins and has_score
		# Keep legacy label in sync if it still exists (fallback)
		if _legacy_label:
			_legacy_label.visible = false
		if label and label != _coins_label and label != _points_label:
			# If exported label points to legacy, keep it updated for compatibility
			if has_coins and has_score:
				label.text = "%d/%d ● %d pts" % [_coins_collected, _coins_total, _score]
			elif has_coins:
				label.text = "%d/%d" % [_coins_collected, _coins_total]
			else:
				label.text = "%d pts" % _score
		return
	# Fallback: single label mode (legacy scene)
	var target: Label = label if label else _legacy_label
	if target == null:
		return
	if has_coins and has_score:
		target.text = "%d/%d ● %d pts" % [_coins_collected, _coins_total, _score]
	elif has_coins:
		target.text = "%d/%d" % [_coins_collected, _coins_total]
	else:
		target.text = "%d pts" % _score
