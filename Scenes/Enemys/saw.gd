extends CharacterBody2D

@export var move_speed = 100
@export var move_direction: Vector2

var star_position: Vector2
var target_position: Vector2

func _ready():
    star_position = position
    target_position = position + move_direction 

func _physics_process(delta):
    position = position.move_toward(target_position, move_speed * delta)

    if position == target_position:
        var temp = star_position
        star_position = target_position
        target_position = temp

    
    move_and_slide()