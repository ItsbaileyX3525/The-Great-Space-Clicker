extends Node

var default_data: Dictionary = {
	"score" : Big.new(0),
	"scoremantissa" : null,
	"scoreexpo" : null,
	"prestiges" : {
		"nasaprestiges" : 0,
		"weirdmageddonprestiges" : 0,
		"showprestiges" : 0
	},
	"trueprestiges" : 0,
	"upgrades" : {},
	"nasashop" : {
		"neilarmstrong" : 0,
		"apollo11" : 0,
		"marsrover" : 0,
		"iss" : 0,
		"hubbletelescope" : 0,
		"moonrock" : 0,
		"howardwolowitz" : 0,
	},
	"weirdmageddon" : {
		"blackhole" : 0,
		"whitehole" : 0,
		"neutronstar" : 0,
		"quasars" : 0,
		"wormhole" : 0,
		"darkmatter" : 0,
		"interstellar" : 0,
	},
	"show": {
		"theexpanse" : 0,
		"startrek" : 0,
		"battlestargalatica" : 0,
		"doctorwho" : 0,
		"farscape" : 0,
		"lostinspace" : 0,
		"cowboybebop" : 0
	}
}

var data: Dictionary

func load_data() -> Dictionary:
	if not FileAccess.file_exists("user://userData.json"):
		return default_data

	var loaded_data: String = FileAccess.get_file_as_string("user://userData.json")
	var parsed_data: Dictionary = JSON.parse_string(loaded_data)
	
	parsed_data["score"] = Big.new(parsed_data["scoremantissa"],parsed_data["scoreexpo"])
	return parsed_data

func save_data() -> void:
	var access = FileAccess.open("user://userData.json", FileAccess.WRITE)
	if not access:
		return
	print("Saved data")
	data["scoremantissa"] = data["score"].mantissa
	data["scoreexpo"] = data["score"].exponent
	access.store_string(JSON.stringify(data, "    ", true, true))
	
func _ready() -> void:
	data = load_data()
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 2.5
	add_child(timer)
	timer.start()
	timer.connect("timeout", save_data)
