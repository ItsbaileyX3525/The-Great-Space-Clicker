extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	pass # Replace with function body.


func _on_options_mouse_entered() -> void:
	pass # Replace with function body.


func _on_exit_mouse_entered() -> void:
	pass # Replace with function body.
