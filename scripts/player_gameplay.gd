extends Node2D

@export var sprite:Sprite2D
@export var body_base:Node2D

@export var acceleration:= 400.0
@export var friction:= 350.0

@export var max_speed:= 400.0
var movement_speed:= 0.0
var last_direction:= Vector2.ZERO

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	fly_movement(delta)
	fly_rotate(delta)

func fly_movement(delta):
	var movement_direction = Input.get_vector("left","right","up","down")

	if movement_direction != Vector2.ZERO:
		last_direction = movement_direction.normalized()
		movement_speed +=  acceleration * delta 
	else:
		movement_speed = move_toward(movement_speed,0,friction * delta)
	
	movement_speed = clamp(movement_speed,0,max_speed)
	print()
	position += last_direction * movement_speed * player.velocity_base * delta

func fly_rotate(delta):
	var mouse_position = get_global_mouse_position()
	
	body_base.look_at(mouse_position)
