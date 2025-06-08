extends TextureRect

var direction:Vector2 = Vector2.ZERO
var max_range_stick:float = 100.0
var touch_id:int = -1

var dir_length:Vector2 = Vector2.ZERO

@export var stick:TextureRect

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1 and get_global_rect().has_point(event.position):
			touch_id = event.index
		elif not event.pressed and event.index == touch_id:
			touch_id = -1
			direction = Vector2.ZERO
			dir_length = Vector2.ZERO
			stick.position = size/2 - stick.size/2
	elif event is InputEventScreenDrag and event.index == touch_id:
		var center = global_position + size/2 #capturar o centro da base pra colocar o stick
		var relative = event.position - center #capturar a distancia relativa entre o centro da base e aonde voce pressionou
		
		dir_length = relative
		#stick.look_at(relative)
		direction = relative.normalized()#pra enviar para o player
		
		if relative.length() > max_range_stick:
			relative = relative.normalized() * max_range_stick
		
		stick.position = (size/2) - (stick.size/2) + relative#para mover o joystick aonde está pressionado
