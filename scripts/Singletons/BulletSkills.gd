extends Node


func soft_stun(speed:float):
	var stun = speed / 1.3
	speed = stun
	await get_tree().create_timer(0.2).timeout
	speed = stun * 1.3
