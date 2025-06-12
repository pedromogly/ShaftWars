extends Node


signal display_text_request(who:Node2D,info,global_position:Vector2)

signal enemy_die
signal send_hp(health:int,max_health:int)

signal player_die


func fade_in_animation():
	var fade_layer = CanvasLayer.new()
	var fade_in_img = ColorRect.new()
	
	if not is_instance_valid(get_tree().current_scene):
		await get_tree().process_frame
	fade_layer.add_child(fade_in_img)
	get_tree().root.add_child(fade_layer)
	
	fade_in_img.color = Color.BLACK
	fade_in_img.modulate.a = 1.0
	fade_in_img.size = Vector2(3000,2000)
	var tween = create_tween()
	tween.tween_property(fade_in_img,"modulate:a",0.0,1.5)
	tween.tween_callback(fade_in_img.queue_free)

func fade_out_animation(nextScene:Callable):
	var fade_out_img = ColorRect.new()
	get_tree().current_scene.add_child(fade_out_img)
	fade_out_img.color = Color.BLACK
	fade_out_img.modulate.a = 0.0
	fade_out_img.size = Vector2(3000,2000)
	var tween = create_tween()
	tween.tween_property(fade_out_img,"modulate:a",1.0,1.5)
	tween.tween_callback(nextScene)
