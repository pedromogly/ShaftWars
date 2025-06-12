extends Control

var display = preload("res://prefabs/display_damage.tscn")
var info_stage_text = preload("res://prefabs/controls/info_stage.tscn")
var offset:Vector2 = Vector2(40,0)

@export var timer:Timer
@export var timeSurvive:Label
var seconds:int

func _ready():
	timer.timeout.connect(set_time)
	EventBus.display_text_request.connect(display_text_damage)
	EventBus.player_die.connect(stop_timer)
	init_game_animation()

func _process(delta: float) -> void:
	timeSurvive.text = "TIME SURVIVE: "+str(seconds)

func init_game_animation():
	EventBus.fade_in_animation()
	
	await get_tree().create_timer(0.5).timeout
	var info_text = info_stage_text.instantiate()
	add_child(info_text)
	var text:Label = info_text.find_child("InfoStageLabel")
	text.text = "GET READY!"
	await get_tree().create_timer(3.1).timeout
	info_text.queue_free()
	timer.autostart = true
	timer.start(1.0)

func display_text_damage(who:Node2D,damage:int,gposition:Vector2):
	var displayText = display.instantiate()
	displayText.text = str(damage)
	displayText.global_position = gposition + offset
	if who.is_in_group("player"):
		displayText.add_theme_color_override("font_color",Color.CRIMSON)
	print(displayText)
	add_child(displayText)
	
	var tween_pos = get_tree().create_tween()
	 
	var fade_pos = displayText.global_position + Vector2(10,-70)
	
	tween_pos.set_trans(Tween.TRANS_CUBIC)
	tween_pos.tween_property(displayText,"position",fade_pos,0.3)
	
	tween_pos.set_trans(Tween.TRANS_CUBIC)
	tween_pos.tween_property(displayText,"modulate:a",0.0,0.6)
	tween_pos.tween_callback(displayText.queue_free)
	#await get_tree().create_timer(0.7).timeout

func set_time():
	seconds += 1

func stop_timer():
	timer.stop()
