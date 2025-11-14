extends Control
@onready var main: Control = $"../Main"

var username: String = ""
var can_update: bool = false
var themes := "res://Assets/Themes/Menu.tres"
const MENU := preload("uid://oopr226smwo5")
@onready var player: VBoxContainer = $SmoothScrollContainer/Player

func _on_return_pressed() -> void:
	main.visible = true
	visible = false

signal entries_got
signal entry_sent

@export var api_key: String = "f5dda11f-4d5c-457c-8ea8-a756e0175c91"
@export var base_url: String = "https://api.simpleboards.dev/api/"

@onready var http_request: HTTPRequest = HTTPRequest.new()

func _ready():
	add_child(http_request)
	http_request.connect("request_completed", _on_request_completed)
	entries_got.connect(_on_entries_got)
	can_update = true

func set_api_key(key: String):
	"""Sets the API key for authentication."""
	api_key = key

func get_entries(leaderboard_id: String):
	"""Fetches leaderboard entries for a given leaderboard ID."""
	var url = base_url + "leaderboards/%s/entries" % leaderboard_id
	var headers = ["x-api-key: " + api_key]
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	await http_request.request_completed

func send_score_with_id(leaderboard_id: String, 
		player_display_name: String, 
		score: String,
		metadata: String,
		player_id: String):
	"""Submits a player's score to the leaderboard."""
	var url = base_url + "entries"
	var headers = [
		"x-api-key: " + api_key,
		"Content-Type: application/json"
	]
	var body = {
		"leaderboardId": leaderboard_id,
		"playerId": player_id,
		"playerDisplayName": player_display_name,
		"score": score,
		"metadata": metadata
	}
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(body))
	await http_request.request_completed
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		
func send_score_without_id(leaderboard_id: String, 
		player_display_name: String, 
		score: String,
		metadata: String):
	"""Submits a player's score to the leaderboard."""
	var url = base_url + "entries"
	var headers = [
		"x-api-key: " + api_key,
		"Content-Type: application/json"
	]
	var body = {
		"leaderboardId": leaderboard_id,
		"playerDisplayName": player_display_name,
		"score": score,
		"metadata": metadata
	}
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(body))
	await http_request.request_completed
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _on_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var response = JSON.parse_string(body.get_string_from_utf8())
		if response is Array:
			entries_got.emit(response)
		else:
			entry_sent.emit(response)
	else:
		print("HTTP Request failed: ", response_code, body)

func _on_visibility_changed() -> void:
	if not can_update or not visible:
		return
	var children = player.get_children()
	for e in children:
		e.call_deferred("queue_free")
	get_entries("5a332cc6-c875-4d42-062d-08de239004b6")

func _on_entries_got(entries):
	for entry in entries:
		print(entry)
		
		var score: String = entry.score
		var split = score.split(".", false, 2)

		var raw_mantissa = split[0]
		var mantissa = float("0." + raw_mantissa)

		var expo = int(split[1])
		var reconstructed: String = Big.new(mantissa, expo+1).toAA()
		var label: Label = Label.new()
		label.theme = MENU
		label.text = "%s - %s" % [entry.playerDisplayName, reconstructed]
		player.add_child(label)

func _on_username_text_submitted(new_text: String) -> void:
	username = new_text

func _on_username_text_changed(new_text: String) -> void:
	username = new_text

func _on_submit_pressed() -> void:
	var raw_mantissa = str(Game.data["score"].mantissa)
	var mantissa = int(raw_mantissa.replace(".", ""))

	var exponent = Game.data["score"].exponent
	var score_value = float("%s.%s" % [mantissa, exponent])

	await send_score_without_id(
		"5a332cc6-c875-4d42-062d-08de239004b6",
		username,
		str(score_value),
		"score"
	)
	
	_on_visibility_changed()
