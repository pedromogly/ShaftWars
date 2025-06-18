extends TextureRect

var positionBase:Vector2
var direction:Vector2 = Vector2.ZERO
var dir_noNormalize:Vector2 = Vector2.ZERO #direção para disparar (sem normalização)
var max_range_stick:float = 200.0
var touch_id:int = -1

@export var limitShot:Control
@export var stick:TextureRect

var screenSize

func _ready():
	get_viewport().size_changed.connect(_on_screen_resized)
	_on_screen_resized()
	#Vector2(1673,671)

func _on_screen_resized():
	var screenSize:Vector2 = get_viewport_rect().size
	var marginX = screenSize.x * 0.3
	var marginY = screenSize.y * 0.4
	positionBase = Vector2(screenSize.x - marginX, screenSize.y - marginY)
	return_to_pos()

func return_to_pos():
	position = positionBase

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1:
			if limitShot.get_global_rect().has_point(event.position):
				touch_id = event.index
				var local_pos = event.position
				position = local_pos - size / 2
			else:
				return_to_pos()
				#direction = Vector2.ZERO
				dir_noNormalize = Vector2.ZERO
				stick.position = (size / 2) - (stick.size / 2)
		elif not event.pressed and event.index == touch_id:
			touch_id = -1
			#direction = Vector2.ZERO
			dir_noNormalize = Vector2.ZERO
			stick.position = (size/2) - (stick.size/2)
			return_to_pos()
	elif event is InputEventScreenDrag and event.index == touch_id:
		var center = global_position + size/2 #capturar o centro da base pra colocar o stick
		var relative = event.position - center #capturar a distancia relativa entre o centro da base e aonde voce pressionou
		
		if relative.length() > max_range_stick:
			relative = relative.normalized() * max_range_stick
		dir_noNormalize = relative
		direction = relative.normalized()
		stick.position = (size/2) - (stick.size/2) + relative#para mover o joystick aonde está pressionado
