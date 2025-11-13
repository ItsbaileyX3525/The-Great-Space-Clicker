extends Control
@onready var main: Control = $Main
@onready var shops: Control = $Shops
@onready var score_text_2: Label = $Main/ScoreText2

var can_click: bool = true

func _ready() -> void:
	Big.setDynamicDecimals(false)
	Big.setSmallDecimals(2)
	update_score()

func update_score() -> void:
	score_text_2.text = Game.data["score"].toAA()

func _on_clicker_pressed() -> void:
	if can_click:
		var click_score = Big.new(1)
		Game.data["score"].plusEquals(click_score)
		update_score()
		can_click = false


func _on_click_cd_timeout() -> void:
	can_click = true

func _on_shop_button_pressed() -> void:
	if main.visible:
		main.visible = false
		shops.visible = true
