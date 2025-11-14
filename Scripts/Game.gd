extends Control
@onready var main: Control = $Main
@onready var shops: Control = $Shops
@onready var score_text_2: Label = $Main/ScoreText2
@onready var leaderboard_menu: Control = $Main/LeaderboardMenu
@onready var prestige_shop: Control = $PrestigeShop
@onready var options: Control = $Options

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

func _on_settings_pressed() -> void:
	if not options.visible:
		options.visible = true
		main.visible = false

func _on_leaderboard_pressed() -> void:
	if not leaderboard_menu.visible:
		leaderboard_menu.visible = true
		main.visible = false

func _on_prestige_shop_pressed() -> void:
	if not prestige_shop.visible:
		prestige_shop.visible = true
		main.visible = false
