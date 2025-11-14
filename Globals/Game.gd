extends Node

var default_data: Dictionary = {
	"score": Big.new(0),
	"scoremantissa": null,
	"scoreexpo": null,
	"prestiges": {
		"nasaprestiges": 0,
		"weirdmageddonprestiges": 0,
		"showprestiges": 0
	},
	"trueprestiges": 0,
	"upgrades": {},
	"shops": {
		"nasashop": {
			"neilarmstrong": {
				"purchases": 0,
				"generatepowermantissa": 3.75,
				"generatepowerexpo": -1,
				"pricemantissa": 5,
				"priceexpo": 1,
				"defaultpricemantissa": 5,
				"defaultpriceexpo": 1
			},
			"apollo11": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 0,
				"pricemantissa": 1,
				"priceexpo": 2,
				"defaultpricemantissa": 1,
				"defaultpriceexpo": 2
			},
			"marsrover": {
				"purchases": 0,
				"generatepowermantissa": 3.5,
				"generatepowerexpo": 0,
				"pricemantissa": 2.5,
				"priceexpo": 2,
				"defaultpricemantissa": 2.5,
				"defaultpriceexpo": 2
			},
			"iss": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 1,
				"pricemantissa": 8,
				"priceexpo": 2,
				"defaultpricemantissa": 8,
				"defaultpriceexpo": 2
			},
			"hubbletelescope": {
				"purchases": 0,
				"generatepowermantissa": 2.5,
				"generatepowerexpo": 1,
				"pricemantissa": 2,
				"priceexpo": 3,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 3
			},
			"moonrock": {
				"purchases": 0,
				"generatepowermantissa": 0.5,
				"generatepowerexpo": 2,
				"pricemantissa": 6,
				"priceexpo": 3,
				"defaultpricemantissa": 6,
				"defaultpriceexpo": 3
			},
			"howardwolowitz": {
				"purchases": 0,
				"generatepowermantissa": 2.5,
				"generatepowerexpo": 2,
				"pricemantissa": 2,
				"priceexpo": 4,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 4
			}
		},
		"weirdmageddon": {
			"blackhole": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 3,
				"pricemantissa": 5,
				"priceexpo": 5,
				"defaultpricemantissa": 5,
				"defaultpriceexpo": 5
			},
			"whitehole": {
				"purchases": 0,
				"generatepowermantissa": 2.5,
				"generatepowerexpo": 3,
				"pricemantissa": 1,
				"priceexpo": 6,
				"defaultpricemantissa": 1,
				"defaultpriceexpo": 6
			},
			"neutronstar": {
				"purchases": 0,
				"generatepowermantissa": 0.5,
				"generatepowerexpo": 4,
				"pricemantissa": 5,
				"priceexpo": 6,
				"defaultpricemantissa": 5,
				"defaultpriceexpo": 6
			},
			"quasars": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 4,
				"pricemantissa": 2,
				"priceexpo": 7,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 7
			},
			"wormhole": {
				"purchases": 0,
				"generatepowermantissa": 3,
				"generatepowerexpo": 4,
				"pricemantissa": 6,
				"priceexpo": 7,
				"defaultpricemantissa": 6,
				"defaultpriceexpo": 7
			},
			"darkmatter": {
				"purchases": 0,
				"generatepowermantissa": 0.5,
				"generatepowerexpo": 5,
				"pricemantissa": 2,
				"priceexpo": 8,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 8
			},
			"interstellar": {
				"purchases": 0,
				"generatepowermantissa": 2.5,
				"generatepowerexpo": 5,
				"pricemantissa": 1,
				"priceexpo": 9,
				"defaultpricemantissa": 1,
				"defaultpriceexpo": 9
			}
		},
		"show": {
			"theexpanse": {
				"purchases": 0,
				"generatepowermantissa": 0.5,
				"generatepowerexpo": 6,
				"pricemantissa": 5,
				"priceexpo": 9,
				"defaultpricemantissa": 5,
				"defaultpriceexpo": 9
			},
			"startrek": {
				"purchases": 0,
				"generatepowermantissa": 1.5,
				"generatepowerexpo": 6,
				"pricemantissa": 2,
				"priceexpo": 10,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 10
			},
			"battlestargalatica": {
				"purchases": 0,
				"generatepowermantissa": 0.5,
				"generatepowerexpo": 7,
				"pricemantissa": 6,
				"priceexpo": 10,
				"defaultpricemantissa": 6,
				"defaultpriceexpo": 10
			},
			"doctorwho": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 7,
				"pricemantissa": 3,
				"priceexpo": 11,
				"defaultpricemantissa": 3,
				"defaultpriceexpo": 11
			},
			"farscape": {
				"purchases": 0,
				"generatepowermantissa": 3,
				"generatepowerexpo": 7,
				"pricemantissa": 9,
				"priceexpo": 11,
				"defaultpricemantissa": 9,
				"defaultpriceexpo": 11
			},
			"lostinspace": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 8,
				"pricemantissa": 2,
				"priceexpo": 12,
				"defaultpricemantissa": 2,
				"defaultpriceexpo": 12
			},
			"Kars": {
				"purchases": 0,
				"generatepowermantissa": 3.5,
				"generatepowerexpo": 8,
				"pricemantissa": 5,
				"priceexpo": 12,
				"defaultpricemantissa": 5,
				"defaultpriceexpo": 12
			}
		}
	}
}

var data: Dictionary

func load_data() -> Dictionary:
	if not FileAccess.file_exists("user://userData.json"):
		return default_data

	var loaded_data: String = FileAccess.get_file_as_string("user://userData.json")
	if not len(loaded_data) >= 1:
		print("Data malformed...")
		return default_data

	var parsed_data: Dictionary = JSON.parse_string(loaded_data)
	
	parsed_data["score"] = Big.new(parsed_data["scoremantissa"],parsed_data["scoreexpo"])
	return parsed_data

func save_data() -> void:
	var access = FileAccess.open("user://userData.json", FileAccess.WRITE)
	if not access:
		return
	data["scoremantissa"] = data["score"].mantissa
	data["scoreexpo"] = data["score"].exponent
	access.store_string(JSON.stringify(data, "    ", true, true))

func generate_clicks() -> void:
	var total_power := Big.new(0)

	for category_name in data["shops"].keys():
		var category = data["shops"][category_name]
		for item_name in category.keys():
			var item = category[item_name]
			var power = Big.new(item["generatepowermantissa"], item["generatepowerexpo"])
			var generated = power.multiply(Big.new(item["purchases"]))
			total_power.plusEquals(generated)
			data["score"].plusEquals(total_power)
			var main = get_tree().get_nodes_in_group("main")
			if len(main) > 0:
				get_tree().get_nodes_in_group("main")[0].update_score()

func _ready() -> void:
	data = load_data()
	var save_timer = Timer.new()
	save_timer.one_shot = false
	save_timer.wait_time = 2.5
	add_child(save_timer)
	save_timer.start()
	save_timer.connect("timeout", save_data)

	var generate_timer = Timer.new()
	generate_timer.one_shot = false
	generate_timer.wait_time = 1.0
	add_child(generate_timer)
	generate_timer.start()
	generate_timer.connect("timeout", generate_clicks)
