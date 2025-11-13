extends Control
@onready var nasa_shop: Control = $"../NasaShop"
@onready var weird_shop: Control = $"../WeirdShop"
@onready var show_shop: Control = $"../ShowShop"
@onready var main: Control = $"../Main"
@onready var shops: Control = $"."

func _on_nasa_shop_pressed() -> void:
	if not nasa_shop.visible:
		nasa_shop.visible = true
	
func _on_weird_shop_pressed() -> void:
	if not weird_shop.visible:
		weird_shop.visible = true

func _on_show_shop_pressed() -> void:
	if not show_shop.visible:
		show_shop.visible = true

func _on_return_pressed() -> void:
	shops.visible = false
	main.visible = true
