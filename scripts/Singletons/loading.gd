extends CanvasLayer

@export var color_rect:ColorRect
var tween:Tween

func fade_in():
	reset_tween()
	color_rect.visible = true
	color_rect.modulate.a = 0.0
	tween.tween_property(color_rect,"modulate:a",1.0,1.5)
	await tween.finished

func fade_out():
	reset_tween()
	tween.tween_property(color_rect,"modulate:a",0.0,1.5)
	await tween.finished
	color_rect.visible = false

func transition_to(scene_path:String):
	await fade_in()
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame
	await fade_out()

func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
