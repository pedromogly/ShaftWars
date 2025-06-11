extends Node2D

var mob_count:int = 0
@export var max_sec_random:float
@export var min_sec_random:float

@export var enemy_scene:PackedScene = preload("res://prefabs/enemys/narrow.tscn")

var marksSpawner:Array[Marker2D] = []

var can_spawn:bool = true

func _ready() -> void:
	EventBus.enemy_die.connect(enemy_die_count)
	get_markers()
	spawn()
	

func spawn():
	while can_spawn:
		print(mob_count)
		if marksSpawner.is_empty():
			return
		var time_spawn = randf_range(min_sec_random,max_sec_random)
		var who_mark = randi() % marksSpawner.size()
		await get_tree().create_timer(time_spawn).timeout
		var spawnPoint = marksSpawner[who_mark]
		#if not is_instance_valid(spawnPoint):
		#	return
		if mob_count > 28:
			return
		var enemy = enemy_scene.instantiate()
		get_tree().current_scene.add_child(enemy)
		enemy.global_position = spawnPoint.global_position
		mob_count += 1

func stop_spawn():
	can_spawn = false
	if mob_count < 28:
		can_spawn = true
		
func enemy_die_count():
	mob_count -= 1

func get_markers() -> Array[Marker2D]:
	for child in get_children():
		if child is Marker2D:
			marksSpawner.append(child)
	return marksSpawner
