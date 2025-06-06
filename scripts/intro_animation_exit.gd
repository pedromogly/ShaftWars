extends Control

@export var sprite:Sprite2D

var nextScene:PackedScene = preload("res://scenes/main_menu.tscn")

func _ready() -> void:
	tween_test()
	#await get_tree().create_timer(3.0).timeout

func _process(delta: float) -> void:
	print(sprite.modulate.a)
	
func tween_test():
	sprite.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(sprite,"modulate:a",1.0,2.0)
	tween.tween_property(sprite,"modulate:a",0.0,1.0).set_delay(3.0)
	tween.tween_callback(next)

func next():
	get_tree().change_scene_to_packed(nextScene)
