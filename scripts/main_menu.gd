extends Control

@onready var enteredAnim = %fade_in

func _ready() -> void:
	entered_menu()


func entered_menu():
	var tween = create_tween()
	tween.tween_property(enteredAnim,"modulate:a",0.0,1.0)
	tween.tween_callback(func(): enteredAnim.visible=false)
