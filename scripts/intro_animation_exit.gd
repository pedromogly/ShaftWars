extends Control

@export var sprite:Sprite2D

func _ready() -> void:
	tween_test()
	#await get_tree().create_timer(3.0).timeout

func _process(delta: float) -> void:
	pass

func tween_test():
	
	await get_tree().create_timer(4.0).timeout
	
	EventBus.fade_out_animation(func(): SceneBus.goto_scene("res://scenes/main_menu.tscn"))
