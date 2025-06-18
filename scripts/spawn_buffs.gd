extends Node2D

var marksSpawner:Array[Marker2D] = []
var cure_scene:PackedScene = preload("res://prefabs/buffs/cure_buff.tscn")

var can_spawn:bool = true

func _ready() -> void:
	get_markers()
	await get_tree().create_timer(1.0).timeout
	spawn()

func spawn():
	while can_spawn:
		var secondNextSpawn = randf_range(10.0,30.0)
		var selectSpawnSpot = randi_range(0,marksSpawner.size() - 1)
		
		await get_tree().create_timer(secondNextSpawn).timeout
		var cure_instance = cure_scene.instantiate()
		get_tree().current_scene.add_child(cure_instance)
		cure_instance.global_position = marksSpawner[selectSpawnSpot].global_position


func get_markers():
	for child in get_children():
		marksSpawner.append(child)
