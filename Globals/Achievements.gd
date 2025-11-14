extends Node

var default: Dictionary = {
	"Welcome" : true
}

var data: Dictionary = {}

func load_data() -> Dictionary:
	if not FileAccess.file_exists("user://achievements.json"):
		return default

	var loaded_data: String = FileAccess.get_file_as_string("user://achievements.json")
	var parsed_data: Dictionary = JSON.parse_string(loaded_data)
	return parsed_data

func save_data() -> void:
	var access = FileAccess.open("user://achievements.json", FileAccess.WRITE)
	if not access:
		return
	print("saving:",data)
	access.store_string(JSON.stringify(data,"	"))

func _ready() -> void:
	data = load_data()
	save_data() #Save to file ig, hopefully shouldn't break things :P
	print(data)
