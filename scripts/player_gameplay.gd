extends Node2D

@export var sprite:Sprite2D
@export var body_base:Node2D

@export var joystick:Control

@export var acceleration:= 400.0
@export var friction:= 350.0

@export var max_speed:= 400.0
var movement_speed:= 0.0
var last_direction:= Vector2.ZERO

var sprite_player_instance = preload("res://prefabs/player_sprite.tscn")

@onready var base = joystick.find_child("Base")
@onready var baseShot = joystick.find_child("BaseShot")


var bullet_preload = preload("res://prefabs/bullet.tscn")

var shot_cooldown:float = 0.2
var can_shot:bool = true

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	fly_movement(delta)
	fly_rotate()

func fly_movement(delta):
	var velocity_base = player.velocity_base
	var movement_direction = base.get_direction()

	if movement_direction != Vector2.ZERO:
		last_direction = movement_direction.normalized()
		movement_speed +=  acceleration * delta 
		
	else:
		movement_speed = move_toward(movement_speed,0,friction * delta)
		velocity_base = 0
	
	movement_speed = clamp(movement_speed,0,max_speed)
	position += last_direction * (movement_speed + velocity_base) * delta

func fly_rotate():
	#var mouse_position = get_global_mouse_position()
	print(baseShot.dir_length.length())
	if baseShot.dir_length.length() > 40.0:
		body_base.rotation = baseShot.dir_length.angle()

	
	if baseShot.dir_length.length() > 50.0 and can_shot:
		shot()
		can_shot = false
		await get_tree().create_timer(shot_cooldown).timeout
		can_shot = true

func shot():
	
	var bullet_instance = bullet_preload.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	
	bullet_instance.global_position = global_position
	bullet_instance.set_direction_bullet(baseShot.direction)
