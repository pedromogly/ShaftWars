extends VBoxContainer

@export var bt_newgame:Button
@export var bt_loadgame:Button
@export var bt_config:Button
@export var bt_quit:Button

func _ready():
	bt_newgame.button_up.connect(_newgame_pressed)
	bt_quit.connect("button_up",quit_pressed)

func _newgame_pressed():
	EventBus.fade_out_animation(func(): SceneBus.goto_scene("res://scenes/levels/level_introduce.tscn"))

func quit_pressed():
	get_tree().quit()
