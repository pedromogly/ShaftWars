extends Node

class_name Player

var base_health:int = 110
var max_health:int = base_health #aqui na frente a evolução


var damage_base:int = 29
var max_damage:int = 38

@export var velocity_base:float = 90.0

func _ready():
	add_to_group("players")
