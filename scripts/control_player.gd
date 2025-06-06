extends TextureRect

@export var radius:float = 100.0
var direction:= Vector2.ZERO
var touch_id:int = -1

@export var stick:TextureRect

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1 and get_global_rect().has_point(event.position):
			touch_id = event.index
		elif not event.pressed and event.index == touch_id:
			touch_id = -1
			direction = Vector2.ZERO
			stick.position = (size / 2) - (stick.size/2)
	elif event is InputEventScreenDrag and event.index == touch_id:
		var center = global_position + size / 2
		var relative = event.position - center
		
		if relative.length() > radius:
			relative = relative.normalized() * radius 
		
		direction = relative.normalized()
		
		stick.position = (size/2) - (stick.size/2) + relative
		
		
func get_direction() -> Vector2:
	return direction
