extends Node

var offset:Vector2 = Vector2(40,0)

func display_damage(who:Node2D,damage:int,global_position:Vector2):
	var displayText = preload("res://prefabs/display_damage.tscn").instantiate()
	displayText.text = str(damage)
	displayText.global_position = global_position + offset
	if who.is_in_group("player"):
		displayText.add_theme_color_override("font_color",Color.CRIMSON)
	add_child(displayText)
	
	var tween_pos = get_tree().create_tween()
	var fade_out = get_tree().create_tween()
	
	var fade_pos = displayText.global_position + Vector2(10,-70)
	
	tween_pos.set_trans(Tween.TRANS_CUBIC)
	tween_pos.tween_property(displayText,"position",fade_pos,0.3)
	
	tween_pos.set_trans(Tween.TRANS_CUBIC)
	tween_pos.tween_property(displayText,"modulate:a",0.0,0.6)
	await get_tree().create_timer(0.7).timeout
	queue_free()
