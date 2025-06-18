extends Control

@export var stick: TextureRect  # Adicione essa referência
@export var limitBase: Control

var positionBase: Vector2

var touch_id := -1
var radius: float = 200.0  # Mesmo raio do stick
var direction := Vector2.ZERO
var directionShot := Vector2.ZERO

func _ready() -> void:
	get_viewport().size_changed.connect(_on_screen_sized)
	_on_screen_sized()

func _on_screen_sized():
	print("opa")
	var screenSize:Vector2 = get_viewport_rect().size
	var marginX = screenSize.x * 0.95
	var marginY = screenSize.y * 0.4
	positionBase = Vector2(screenSize.x - marginX, screenSize.y - marginY)
	reset_position_local()

func reset_position_local():
	position = positionBase

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1:
			if limitBase.get_global_rect().has_point(event.position):
				touch_id = event.index
				var local_pos = event.position
				position = local_pos - (size / 2)
			else:
				reset_position_local()
				direction = Vector2.ZERO
				stick.position = (size / 2) - (stick.size / 2)
		elif not event.pressed and event.index == touch_id:
			touch_id = -1
			reset_position_local()
			direction = Vector2.ZERO
			directionShot = Vector2.ZERO
			stick.position = (size / 2) - (stick.size / 2)

	elif event is InputEventScreenDrag and event.index == touch_id:
		# Movimento do stick (lógica de arrasto)
		var center = global_position + size / 2
		var relative = event.position - center
		
		if relative.length() > radius:
			relative = relative.normalized() * radius
		
		direction = relative.normalized()
		stick.position = (size / 2) - (stick.size / 2) + relative

func get_direction() -> Vector2:
	return direction
