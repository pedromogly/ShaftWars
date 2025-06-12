extends Node2D

@export var sprite:Sprite2D
@export var hurtbox:Area2D
@export var speed:float = 300.0

@export var damage:int = 14

@export var max_hp:int = 65
var hp:int = max_hp

var target_is_live:bool = true

func _ready() -> void:
	hurtbox.area_entered.connect(hurtbox_c)
	EventBus.player_die.connect(player_die)

func _process(delta: float) -> void:
	if target_is_live:
		enemy_move(delta)

func enemy_move(delta):
	var ptarget = get_tree().get_first_node_in_group("player")
	if ptarget:
		var direction = ptarget.global_position - global_position
		var relative = direction.normalized()
		
		position += relative * speed * delta

func hurtbox_c(body):
	print(body)
	if body.is_in_group("hurtbox_player"):
		var ptarget = body.get_parent()
		ptarget.take_damage(damage)
		
		queue_free()

func take_damage(dmg:int):
	hp -= dmg
	hurtReaction()
	#System.display_damage(self,dmg,global_position)
	EventBus.display_text_request.emit(self,dmg,global_position)
		
	if hp <= 0:
		print("NICE KILL!")
		EventBus.enemy_die.emit()
		queue_free()

func hurtReaction():
	var myModulate = modulate
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"modulate",Color.CYAN,0.2)
	tween.tween_property(sprite,"modulate",myModulate,0.2)

func player_die():
	target_is_live = false
