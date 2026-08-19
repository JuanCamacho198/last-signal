extends CharacterBody2D

signal character_dead
@export var animation: AnimatedSprite2D 
@export var area_2d: Area2D
@export var red_character_material: ShaderMaterial

var _velocity: float = 100.0
var _velocity_jump: float = -300.0
var _dead: bool 

func _ready():
	add_to_group("characters")
	area_2d.body_entered.connect(_on_area_2d_body_entered)


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
	animation.material = red_character_material
	_dead = true
	animation.stop()

	await get_tree().create_timer(0.5).timeout
	character_dead.emit()
	
	GlobalController._plus_death_count()