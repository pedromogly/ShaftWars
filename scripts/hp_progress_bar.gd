extends TextureProgressBar

var tween:Tween
@onready var info_hp:Label = $info_hp
func _ready() -> void:
	EventBus.send_hp.connect(send_hp_to_bar)
	tween = create_tween()

func send_hp_to_bar(hp,max_hp):
	max_value = max_hp
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self,"value",hp,0.3)
	
	info_hp.text = str(hp)+"/"+str(max_hp)
