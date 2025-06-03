extends Node

class_name Player

var base_health:int
var max_health:int

@export var velocity_base:float = 60.0

func _ready():
	add_to_group("players")
