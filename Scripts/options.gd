extends Control

var onWindowMode: int = 0
@onready var window_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/Window/WindowModeText

func _on_prev_window_mode_pressed() -> void:
	onWindowMode -= 1
	if onWindowMode <= -1:
		onWindowMode = 2
	if onWindowMode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		window_label.text = "Windowed"
	elif onWindowMode == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			window_label.text = "Fullscreen"
	elif onWindowMode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		window_label.text = "Windowed (Borderless)"

func _on_next_window_mode_pressed() -> void:
	onWindowMode += 1
	if onWindowMode >= 3:
		onWindowMode = 0
	if onWindowMode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		window_label.text = "Windowed"
	elif onWindowMode == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			window_label.text = "Fullscreen"
	elif onWindowMode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		window_label.text = "Windowed (Borderless)"
