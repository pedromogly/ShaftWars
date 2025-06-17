extends Control

@export var button:Button
@export var scoreText:Label
@export var totalSurvive:Label
@export var totalKills:Label
@export var classAv:Label
var totalScore:int = 0
signal exit_to_menu

func _ready() -> void:
	button.button_up.connect(go_back)

func _process(delta: float) -> void:
	scoreText.text = str(totalScore)

func apply_scorer(newScorer:int,newSurvive:int,newKills:int):
	var tween = create_tween()
	tween.tween_property(self,"totalScore",newScorer,2.0)
	totalSurvive.text = str(newSurvive)
	totalKills.text = str(newKills)
	apply_class(newScorer)

func go_back():
	Loading.transition_to("res://scenes/main_menu.tscn")
	exit_to_menu.emit()
	
func apply_class(scorer:int):
	if scorer >= 3000:
		classAv.text = "A+"
		return
	if scorer >= 2000:
		classAv.text = "A-"
		return
	if scorer >= 1500:
		classAv.text = "B+"
		return
	if scorer >= 1200:
		classAv.text = "B-"
		return
	if scorer >= 900:
		classAv.text = "C+"
		return
	if scorer >= 700:
		classAv.text = "C-"
		return
	if scorer >= 500:
		classAv.text = "D+"
		return
	if scorer >= 300:
		classAv.text = "D-"
		return
	if scorer >= 0:
		classAv.text = "F"
		return
