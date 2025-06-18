extends Node2D

var can_cure:bool = true

@export var area:Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.area_entered.connect(_on_area_entered)

func _on_area_entered(body:Node2D):
	var cure_factor = randi_range(20,43)
	
	if body.is_in_group("hurtbox_player") and can_cure:
		can_cure = false
		var playertarget = body.get_parent()
		playertarget.cure(cure_factor)
		var tween = create_tween()
		tween.tween_property(self,"scale",Vector2(0.0,0.0),0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_callback(queue_free)
