extends Control
@onready var window_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/Window/WindowModeText
@onready var master_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MasterVolume/MarginContainer2/MasterVolLabel
@onready var music_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MusicVolume/MarginContainer2/MusicVolLabel
@onready var sfx_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/SFXVolume/MarginContainer2/SFXVolLabel

var onWindowMode: int = 0


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


func _on_master_volume_slider_value_changed(value: float) -> void:
	master_vol_label.text =  str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)

func _on_music_volume_slider_value_changed(value: float) -> void:
	music_vol_label.text = str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)

func _on_sfx_slider_value_changed(value: float) -> void:
	sfx_vol_label.text =  str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)
