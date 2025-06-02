extends Control

@onready var sprite:Sprite2D = $DbVer1_
var fade_speed = 0.5
var letsExit = false

var nextScene:PackedScene = preload("res://scenes/main_menu.tscn")

func _ready() -> void:
	
	await get_tree().create_timer(3.0).timeout
	letsExit = true

func _process(delta: float) -> void:
	print(sprite.modulate.a)
	if letsExit:
		if sprite.modulate.a > 0:
			sprite.modulate.a -= fade_speed * delta
	
	if sprite.modulate.a <= 0:
		get_tree().change_scene_to_packed(nextScene)
	
	
