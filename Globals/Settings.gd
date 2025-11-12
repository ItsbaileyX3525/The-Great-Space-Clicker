extends Node

var default_settings: Dictionary = {
	"masterVol" : 50,
	"musicVol" : 50,
	"sfxVol" : 50,
	"windowMode" : 0,
	"resolution" : "1152x648"
}

var current_save: Dictionary = {}

func load_settings() -> void:
	#Load window related data
	if int(current_save["windowMode"]) == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif int(current_save["windowMode"]) == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif int(current_save["windowMode"]) == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

	#Load audio busses
	var master_audio_bus := AudioServer.get_bus_index("Master")
	var music_audio_bus := AudioServer.get_bus_index("Music")
	var sfx_audio_bus := AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(master_audio_bus, float(current_save["masterVol"])/50)
	AudioServer.set_bus_volume_linear(music_audio_bus, float(current_save["musicVol"])/50)
	AudioServer.set_bus_volume_linear(sfx_audio_bus, float(current_save["sfxVol"])/50)

func load_data() -> Dictionary:
	if not FileAccess.file_exists("user://settings.json"):
		return default_settings

	var loaded_data: String = FileAccess.get_file_as_string("user://settings.json")
	var parsed_data: Dictionary = JSON.parse_string(loaded_data)
	return parsed_data

func save_data() -> void:
	var access = FileAccess.open("user://settings.json", FileAccess.WRITE)
	if not access:
		return
	print("saving:",current_save)
	access.store_string(JSON.stringify(current_save))
	

func _ready() -> void:
	current_save = load_data()
	print(current_save)
	load_settings()
