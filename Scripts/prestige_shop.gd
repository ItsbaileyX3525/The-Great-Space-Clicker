extends Control

@onready var animation_player: AnimationPlayer = $Morshu/AnimationPlayer
@onready var main: Control = $"../Main"

var can_do_stuff: bool = false

func _on_visibility_changed() -> void:
	if not can_do_stuff:
		return
	
	if not visible:
		return
		
	if not Game.data["score"].isGreaterThanOrEqualTo(Big.new(5.0, 7)): #50Milly
		animation_player.play("play")
		await animation_player.animation_finished
		print("animation finished")
		visible = false
		main.visible = true

func _ready() -> void:
	can_do_stuff = true
