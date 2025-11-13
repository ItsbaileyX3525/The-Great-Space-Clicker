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
				"generatepowermantissa": 7.5,
				"generatepowerexpo": -1, #0.75
				"pricemantissa": 5,
				"priceexpo": 1     #50
			},
			"apollo11": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 0,   #2
				"pricemantissa": 1,
				"priceexpo": 2            #100
			},
			"marsrover": {
				"purchases": 0,
				"generatepowermantissa": 7,
				"generatepowerexpo": 0,   #7
				"pricemantissa": 2.5,
				"priceexpo": 2            #250
			},
			"iss": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 1,   #20
				"pricemantissa": 8,
				"priceexpo": 2            #800
			},
			"hubbletelescope": {
				"purchases": 0,
				"generatepowermantissa": 5,
				"generatepowerexpo": 1,   #50
				"pricemantissa": 2,
				"priceexpo": 3            #2000
			},
			"moonrock": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 2,   #100
				"pricemantissa": 6,
				"priceexpo": 3            #6000
			},
			"howardwolowitz": {
				"purchases": 0,
				"generatepowermantissa": 5,
				"generatepowerexpo": 2,   #500
				"pricemantissa": 2,
				"priceexpo": 4            #20000
			}
		},
		"weirdmageddon": {
			"blackhole": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 3,   #2000
				"pricemantissa": 5,
				"priceexpo": 5            #500000
			},
			"whitehole": {
				"purchases": 0,
				"generatepowermantissa": 5,
				"generatepowerexpo": 3,   #5000
				"pricemantissa": 1,
				"priceexpo": 6            #1000000
			},
			"neutronstar": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 4,   #10000
				"pricemantissa": 5,
				"priceexpo": 6            #5000000
			},
			"quasars": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 4,   #20000
				"pricemantissa": 2,
				"priceexpo": 7            #20000000
			},
			"wormhole": {
				"purchases": 0,
				"generatepowermantissa": 6,
				"generatepowerexpo": 4,   #60000
				"pricemantissa": 6,
				"priceexpo": 7            #60000000
			},
			"darkmatter": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 5,   #100000
				"pricemantissa": 2,
				"priceexpo": 8            #200000000
			},
			"interstellar": {
				"purchases": 0,
				"generatepowermantissa": 5,
				"generatepowerexpo": 5,   #500000
				"pricemantissa": 1,
				"priceexpo": 9            #1000000000
			}
		},
		"show": {
			"theexpanse": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 6,
				"pricemantissa": 5,
				"priceexpo": 9
			},
			"startrek": {
				"purchases": 0,
				"generatepowermantissa": 3,
				"generatepowerexpo": 6,
				"pricemantissa": 2,
				"priceexpo": 10
			},
			"battlestargalatica": {
				"purchases": 0,
				"generatepowermantissa": 1,
				"generatepowerexpo": 7,
				"pricemantissa": 6,
				"priceexpo": 10
			},
			"doctorwho": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 7,
				"pricemantissa": 3,
				"priceexpo": 11
			},
			"farscape": {
				"purchases": 0,
				"generatepowermantissa": 6,
				"generatepowerexpo": 7,
				"pricemantissa": 9,
				"priceexpo": 11
			},
			"lostinspace": {
				"purchases": 0,
				"generatepowermantissa": 2,
				"generatepowerexpo": 8,
				"pricemantissa": 2,
				"priceexpo": 12
			},
			"cowboybebop": {
				"purchases": 0,
				"generatepowermantissa": 7,
				"generatepowerexpo": 8,
				"pricemantissa": 5,
				"priceexpo": 12
			}
		}
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

func generate_clicks() -> void:
	var total_power := Big.new(0)

	for category_name in default_data["shops"].keys():
		var category = default_data["shops"][category_name]
		for item_name in category.keys():
			var item = category[item_name]
			var power = Big.new(item["generatepowermantissa"], item["generatepowerexpo"])
			var generated = power.multiply(Big.new(item["purchases"]))
			total_power.plusEquals(generated)
			data["score"].plusEquals(total_power)

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
