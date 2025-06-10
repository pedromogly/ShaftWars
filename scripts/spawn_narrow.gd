extends Marker2D

var mob_count:int = 0
@export var max_sec_random:float = 3.0
@export var min_sec_random:float = 0.5

@export var enemy_scene:PackedScene = preload("res://prefabs/enemys/narrow.tscn")
func _ready() -> void:
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn():
	while mob_count < 20:
		var time_spawn = randf_range(min_sec_random,max_sec_random)
		
		if mob_count <= 28:
			await get_tree().create_timer(time_spawn).timeout
			var enemy = enemy_scene.instantiate()
			add_child(enemy)
			enemy.global_position = global_position
			mob_count += 1
