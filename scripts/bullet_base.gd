extends Node2D

var speed:float = 1200.0
var direction = Vector2.ZERO

func _process(delta):
	position += direction * speed * delta

func set_direction_bullet(new_direction:Vector2):
	direction = new_direction
	rotation = direction.angle()
