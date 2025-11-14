extends Control
@onready var one_more_game: AudioStreamPlayer = $OneMoreGame
@onready var one_more_game_sprite: Sprite2D = $OneMoreGameSprite
@onready var start: Button = $VBoxContainer/Start
@onready var options: Button = $VBoxContainer/Options
@onready var exit: Button = $VBoxContainer/Exit

var main_scene = preload("res://Scenes/main.tscn")

var scale_amount: float = 1.05

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_mouse_entered() -> void:
	start.scale *= scale_amount

func _on_start_mouse_exited() -> void:
	start.scale /= scale_amount

func _on_options_mouse_entered() -> void:
	options.scale *= scale_amount

func _on_options_mouse_exited() -> void:
	options.scale /= scale_amount

func _on_exit_mouse_entered() -> void:
	exit.scale *= scale_amount
	one_more_game.play()
	one_more_game_sprite.visible = true

func _on_exit_mouse_exited() -> void:
	exit.scale /= scale_amount
	one_more_game.stop()
	one_more_game_sprite.visible = false
