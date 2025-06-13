extends Control

@export var base: TextureRect
@export var stick: TextureRect  # Adicione essa referência
@export var limitBase: Control
var positionBase: Vector2

var touch_id := -1
var radius: float = 150.0  # Mesmo raio do stick
var direction := Vector2.ZERO

func _ready() -> void:
	positionBase = base.position
	print(positionBase)
	reset_position_local()
	
func reset_position_local():
	base.position = positionBase
	

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_id == -1:
			if limitBase.get_global_rect().has_point(event.position):
				# Primeiro toque: posiciona a base
				touch_id = event.index
				var local_pos = get_global_transform().affine_inverse() * event.position
				base.position = local_pos - base.size / 2
			else:
				# Toque fora do limite: reseta a base
				reset_position_local()
				direction = Vector2.ZERO
				stick.position = (base.size / 2) - (stick.size / 2)
		elif not event.pressed and event.index == touch_id:
			# Soltou o dedo: reseta o stick
			touch_id = -1
			reset_position_local()
			direction = Vector2.ZERO
			stick.position = (base.size / 2) - (stick.size / 2)

	elif event is InputEventScreenDrag and event.index == touch_id:
		# Movimento do stick (lógica de arrasto)
		var center = base.global_position + base.size / 2
		var relative = event.position - center
		
		if relative.length() > radius:
			relative = relative.normalized() * radius
		
		direction = relative.normalized()
		stick.position = (base.size / 2) - (stick.size / 2) + relative

func get_direction() -> Vector2:
	return direction
