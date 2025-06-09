extends Node2D

@export var collision:Area2D
var speed:float = 1200.0
var direction = Vector2.ZERO

var damage:int = player.damage_base

func _ready():
	collision.area_entered.connect(collision_now)
	
	await get_tree().create_timer(3.0).timeout
	queue_free()

func _process(delta):
	position += direction * speed * delta

func set_direction_bullet(new_direction:Vector2):
	direction = new_direction
	rotation = direction.angle()
	

func collision_now(body_area):
	if body_area.is_in_group("hurtbox_enemy"):
		var body = body_area.get_parent()
		if body:
			body.take_damage(damage)
			
			queue_free()
