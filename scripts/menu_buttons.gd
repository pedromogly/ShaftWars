extends VBoxContainer

@export var bt_newgame:Button
@export var bt_loadgame:Button
@export var bt_config:Button
@export var bt_quit:Button

func _ready():
	bt_quit.connect("button_up",quit_pressed)

func quit_pressed():
	get_tree().quit()
