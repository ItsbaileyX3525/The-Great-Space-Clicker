extends Control
@onready var window_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/Window/WindowModeText
@onready var master_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MasterVolume/MarginContainer2/MasterVolLabel
@onready var music_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/MusicVolume/MarginContainer2/MusicVolLabel
@onready var sfx_vol_label: Label = $Settings/SmoothScrollContainer/VBoxContainer/SFXVolume/MarginContainer2/SFXVolLabel
@onready var master_volume_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/MasterVolume/MarginContainer/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/MusicVolume/MarginContainer/MusicVolumeSlider
@onready var sfx_slider: HSlider = $Settings/SmoothScrollContainer/VBoxContainer/SFXVolume/MarginContainer/SFXSlider
@onready var resolution_text: Label = $Settings/SmoothScrollContainer/VBoxContainer/Resolution/ResolutionText
@onready var options: Control = $"."
@onready var main: Control = $"../Main"
@onready var page_1: SmoothScrollContainer = $Settings/SmoothScrollContainer
@onready var page_2: SmoothScrollContainer = $Settings/Page2
@onready var music_chosen: OptionButton = $Settings/Page2/VBoxContainer/Music/MusicChosen
@onready var music_category_option: OptionButton = $Settings/Page2/VBoxContainer/MusicCategory/MusicCategoryOption

var onWindowMode: int = 0
var onResolution: int = 0

func load_positions() -> void:
	match int(Settings.current_save["windowMode"]):
		0:
			window_label.text = "Windowed"
		1:
			window_label.text = "Fullscreen"
		2:
			window_label.text = "Windowed (Borderless)"
		
	match int(Settings.current_save["resolution"]):
		0:
			resolution_text.text = "1152x648"
		1:
			resolution_text.text = "1280x720"
		2:
			resolution_text.text = "1920x1080"
		3:
			resolution_text.text = "2560x1440"
	
	master_vol_label.text = str(round(int(Settings.current_save["masterVol"])))
	music_vol_label.text = str(round(int(Settings.current_save["musicVol"])))
	sfx_vol_label.text = str(round(int(Settings.current_save["sfxVol"])))
	master_volume_slider.value = round(int(Settings.current_save["masterVol"]))
	music_volume_slider.value = round(int(Settings.current_save["musicVol"]))
	sfx_slider.value = round(int(Settings.current_save["sfxVol"]))
	
	music_category_option.select(Settings.current_save["musicCategory"])
	_on_music_category_option_item_selected(Settings.current_save["musicCategory"])
	music_chosen.select(Settings.current_save["musicChoice"])
	
	MusicManager.play_music(Settings.current_save["musicCategory"], Settings.current_save["musicChoice"])
	
func _ready() -> void:
	load_positions()

func _on_return_pressed() -> void:
	main.visible = true
	options.visible = false

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
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_position(Vector2i(0,0))
			window_label.text = "Fullscreen"
			Settings.current_save["windowMode"] = 1
	elif onWindowMode == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		DisplayServer.window_set_position(Vector2i(0,0))
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

func _on_next_resolution_pressed() -> void:
	onResolution += 1
	if onResolution > 3:
		onResolution = 0

	match onResolution:
		0:
			DisplayServer.window_set_size(Vector2i(1152, 648))
			resolution_text.text = "1152x648"
			Settings.current_save["resolution"] = 0
		1:
			DisplayServer.window_set_size(Vector2i(1280, 720))
			resolution_text.text = "1280x720"
			Settings.current_save["resolution"] = 1
		2:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			resolution_text.text = "1920x1080"
			Settings.current_save["resolution"] = 2
		3:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
			resolution_text.text = "2560x1440"
			Settings.current_save["resolution"] = 3

	Settings.save_data()

func _on_prev_resolution_pressed() -> void:
	onResolution -= 1
	if onResolution < 0:
		onResolution = 3

	match onResolution:
		0:
			DisplayServer.window_set_size(Vector2i(1152, 648))
			resolution_text.text = "1152x648"
			Settings.current_save["resolution"] = 0
		1:
			DisplayServer.window_set_size(Vector2i(1280, 720))
			resolution_text.text = "1280x720"
			Settings.current_save["resolution"] = 1
		2:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			resolution_text.text = "1920x1080"
			Settings.current_save["resolution"] = 2
		3:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
			resolution_text.text = "2560x1440"
			Settings.current_save["resolution"] = 3

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

func _on_code_input_text_submitted(new_text: String) -> void:
	print(new_text)

func _on_next_settings_pressed() -> void:
	if page_1.visible:
		page_1.visible = false
		page_2.visible = true
	else:
		page_1.visible = true
		page_2.visible = false

func _on_click_choice_item_selected(index: int) -> void:
	Settings.current_save["clickSound"] = index
	Settings.save_data()

func _on_music_chosen_item_selected(index: int) -> void:
	Settings.current_save["musicChoice"] = index
	Settings.save_data()
	MusicManager.play_music(Settings.current_save["musicCategory"], Settings.current_save["musicChoice"])

func _on_music_category_option_item_selected(index: int) -> void:
	music_chosen.clear()
	Settings.current_save["musicCategory"] = index
	match index:
		0: #Default
			music_chosen.add_item(" Spacedog ")
		1: #Anime
			music_chosen.add_item(" Tit For Tat ")
			music_chosen.add_item(" Platnium Disco ")
			music_chosen.add_item(" Kekka Orai ")
			music_chosen.add_item(" Distance ")
			music_chosen.add_item(" StorySeeker ")
		2: #One piece
			pass
		3: #JOJO!!!
			music_chosen.add_item(" Crazy Noisy Town ")
			music_chosen.add_item(" Bloody Stream ")
			music_chosen.add_item(" Il vento d'oro ")
			music_chosen.add_item(" Roundabout ")
			music_chosen.add_item(" Sono chi no kioku ")
			
