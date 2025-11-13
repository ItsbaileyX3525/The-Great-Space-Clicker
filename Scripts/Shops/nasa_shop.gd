extends Control
@onready var shops: Control = $"../Shops"
@onready var nasa_shop: Control = $"."
@onready var gen_1_price: Label = $Gen1/Gen1Price
@onready var gen_2_price: Label = $Gen2/Gen2Price
@onready var gen_3_price: Label = $Gen3/Gen3Price
@onready var gen_4_price: Label = $Gen4/Gen4Price
@onready var gen_5_price: Label = $Gen5/Gen5Price
@onready var gen_6_price: Label = $Gen6/Gen6Price
@onready var gen_7_price: Label = $Gen7/Gen7Price
@onready var score_text_2: Label = $ScoreText2
@onready var main: Control = $".."

var update_timer: Timer
var can_update: bool = false

func _ready() -> void:
	can_update = true

func load_stuff() -> void:
	score_text_2.text = Game.data["score"].toAA()
	get_tree().get_nodes_in_group("main")[0].update_score()
	var gen1Item = Game.data["shops"]["nasashop"]["neilarmstrong"]
	var gen2Item = Game.data["shops"]["nasashop"]["apollo11"]
	var gen3Item = Game.data["shops"]["nasashop"]["marsrover"]
	var gen4Item = Game.data["shops"]["nasashop"]["iss"]
	var gen5Item = Game.data["shops"]["nasashop"]["hubbletelescope"]
	var gen6Item = Game.data["shops"]["nasashop"]["moonrock"]
	var gen7Item = Game.data["shops"]["nasashop"]["howardwolowitz"]
	var gen1Price = "Cost: " + Big.new(gen1Item["pricemantissa"], gen1Item["priceexpo"]).toAA()
	var gen2Price = "Cost: " + Big.new(gen2Item["pricemantissa"], gen2Item["priceexpo"]).toAA()
	var gen3Price = "Cost: " + Big.new(gen3Item["pricemantissa"], gen3Item["priceexpo"]).toAA()
	var gen4Price = "Cost: " + Big.new(gen4Item["pricemantissa"], gen4Item["priceexpo"]).toAA()
	var gen5Price = "Cost: " + Big.new(gen5Item["pricemantissa"], gen5Item["priceexpo"]).toAA()
	var gen6Price = "Cost: " + Big.new(gen6Item["pricemantissa"], gen6Item["priceexpo"]).toAA()
	var gen7Price = "Cost: " + Big.new(gen7Item["pricemantissa"], gen7Item["priceexpo"]).toAA()
	gen_1_price.text = gen1Price
	gen_2_price.text = gen2Price
	gen_3_price.text = gen3Price
	gen_4_price.text = gen4Price
	gen_5_price.text = gen5Price
	gen_6_price.text = gen6Price
	gen_7_price.text = gen7Price

func _on_visibility_changed() -> void:
	if not can_update:
		return
	update_timer = Timer.new()
	update_timer.one_shot = false
	update_timer.wait_time = 0.8
	add_child(update_timer)
	update_timer.start()
	update_timer.connect("timeout", load_stuff)

	load_stuff()

func _on_return_pressed() -> void:
	if nasa_shop.visible:
		nasa_shop.visible = false
		shops.visible = true
		update_timer.call_deferred("queue_free")

func _on_gen_1_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["neilarmstrong"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_2_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["apollo11"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
		
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_3_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["marsrover"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
		
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_4_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["iss"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
		
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_5_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["hubbletelescope"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
		
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_6_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["moonrock"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return
		
	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()

func _on_gen_7_pressed() -> void:
	var item = Game.data["shops"]["nasashop"]["howardwolowitz"]
	var genPrice: Big = Big.new(float(item["pricemantissa"]), int(item["priceexpo"]))
	var curr_score: Big = Game.data["score"]
	if not curr_score.isGreaterThanOrEqualTo(genPrice):
		return

	Game.data["score"].minusEquals(genPrice)
	item["purchases"] += 1
	
	var growth_multiplier := 1.18
	
	var new_mantissa = item["pricemantissa"] * growth_multiplier
	var new_exponent = item["priceexpo"]
	
	if new_mantissa >= 10:
		new_mantissa /= 10
		new_exponent += 1
	
	item["pricemantissa"] = new_mantissa
	item["priceexpo"] = new_exponent
	load_stuff()
