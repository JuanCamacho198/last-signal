extends CharacterBody2D

signal character_dead
@export var animation: AnimatedSprite2D 
@export var area_2d: Area2D
@export var red_character_material: ShaderMaterial

@export var boost_duration: float = 7.0
@export var boost_speed_mult: float = 1.6
@export var boost_jump_mult: float = 1.3

var _base_velocity: float = 100.0
var _base_jump: float = -300.0
var _velocity: float = 100.0
var _velocity_jump: float = -300.0
var _dead: bool
var _is_boosted: bool = false
var _boost_timer: Timer
var _original_modulate: Color = Color.WHITE

func _ready():
	add_to_group("characters")
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	_setup_boost_timer()
	if animation:
		_original_modulate = animation.modulate


func _physics_process(delta):
	if _dead:
		return

	#gravity
	velocity += get_gravity() * delta
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _velocity_jump

	#movement
	if Input.is_action_pressed("right"):
		velocity.x = _velocity
		animation.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -_velocity
		animation.flip_h = true
	else:
		velocity.x = 0

	move_and_slide()

	#animation
	if !is_on_floor():
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func _on_area_2d_body_entered(_body: Node) -> void:
	# cancel boost so death visual is clean
	if _is_boosted:
		_boost_timer.stop()
		_is_boosted = false
		_velocity = _base_velocity
		_velocity_jump = _base_jump
		if animation:
			animation.modulate = _original_modulate
	animation.material = red_character_material
	_dead = true
	animation.stop()

	await get_tree().create_timer(0.5).timeout
	character_dead.emit()
	
	GlobalController._plus_death_count()

func _setup_boost_timer() -> void:
	_boost_timer = get_node_or_null("BoostTimer") as Timer
	if _boost_timer == null:
		_boost_timer = Timer.new()
		_boost_timer.name = "BoostTimer"
		_boost_timer.one_shot = true
		_boost_timer.wait_time = boost_duration
		add_child(_boost_timer)
	else:
		_boost_timer.one_shot = true
		_boost_timer.wait_time = boost_duration
	if not _boost_timer.timeout.is_connected(_on_boost_timeout):
		_boost_timer.timeout.connect(_on_boost_timeout)

func apply_energy_boost(duration: float = 7.0) -> void:
	if _dead:
		return
	if duration <= 0.0:
		duration = boost_duration
	_is_boosted = true
	_velocity = _base_velocity * boost_speed_mult
	_velocity_jump = _base_jump * boost_jump_mult
	if animation:
		animation.modulate = Color(0.5, 1.0, 0.8)
	_boost_timer.wait_time = duration
	_boost_timer.start()

func _on_boost_timeout() -> void:
	_is_boosted = false
	_velocity = _base_velocity
	_velocity_jump = _base_jump
	if animation:
		animation.modulate = _original_modulate
