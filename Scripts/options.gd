extends Control
@onready var window_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/Window/WindowModeText
@onready var master_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MasterVolume/MarginContainer2/MasterVolLabel
@onready var music_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MusicVolume/MarginContainer2/MusicVolLabel
@onready var sfx_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/SFXVolume/MarginContainer2/SFXVolLabel
@onready var master_volume_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/MasterVolume/MarginContainer/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/MusicVolume/MarginContainer/MusicVolumeSlider
@onready var sfx_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/SFXVolume/MarginContainer/SFXSlider

var onWindowMode: int = 0

func load_positions() -> void:
	match int(Settings.current_save["windowMode"]):
		0:
			window_label.text = "Windowed"
		1:
			window_label.text = "Fullscreen"
		2:
			window_label.text = "Windowed (Borderless)"
	
	master_vol_label.text = str(round(int(Settings.current_save["masterVol"])))
	music_vol_label.text = str(round(int(Settings.current_save["musicVol"])))
	sfx_vol_label.text = str(round(int(Settings.current_save["sfxVol"])))
	master_volume_slider.value = round(int(Settings.current_save["masterVol"]))
	music_volume_slider.value = round(int(Settings.current_save["musicVol"]))
	sfx_slider.value = round(int(Settings.current_save["sfxVol"]))
	
func _ready() -> void:
	load_positions()

func _on_prev_window_mode_pressed() -> void:
	onWindowMode -= 1
	if onWindowMode <= -1:
		onWindowMode = 2
	if onWindowMode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		window_label.text = "Windowed"
		Settings.current_save["windowMode"] = 0
	elif onWindowMode == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			window_label.text = "Fullscreen"
			Settings.current_save["windowMode"] = 1
	elif onWindowMode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		window_label.text = "Windowed (Borderless)"
		Settings.current_save["windowMode"] = 2
	Settings.save_data()

func _on_next_window_mode_pressed() -> void:
	onWindowMode += 1
	if onWindowMode >= 3:
		onWindowMode = 0
	if onWindowMode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		window_label.text = "Windowed"
		Settings.current_save["windowMode"] = 0
	elif onWindowMode == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			window_label.text = "Fullscreen"
			Settings.current_save["windowMode"] = 1
	elif onWindowMode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		window_label.text = "Windowed (Borderless)"
		Settings.current_save["windowMode"] = 2
	Settings.save_data()
	
func _on_master_volume_slider_value_changed(value: float) -> void:
	master_vol_label.text =  str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)
	Settings.current_save["masterVol"] = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	music_vol_label.text = str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)
	Settings.current_save["musicVol"] = value

func _on_sfx_slider_value_changed(value: float) -> void:
	sfx_vol_label.text =  str(int(round(value)))
	var audio_bus := AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(audio_bus, value/50)
	Settings.current_save["sfxVol"] = value

func _on_master_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed: #Just stops un-needed write requests
		Settings.save_data()

func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Settings.save_data()

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Settings.save_data()
