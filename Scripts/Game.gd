extends Control
@onready var score_text_2: Label = $ScoreText2
@onready var main: Control = $Main
@onready var shops: Control = $Shops

func _ready() -> void:
	update_score()

func update_score() -> void:
	score_text_2.text = str(int(Game.data["score"].toString()))

func _on_clicker_pressed() -> void:
	var click_score: int = 1
	Game.data["score"].plusEquals(click_score)
	
	update_score()
