extends Node

var audio_player: AudioStreamPlayer

var default_music: Array = [
	preload("uid://eu5llovvit86"),
]

var anime_music: Array = [
	preload("uid://c0u1loar0xr52"),
	preload("uid://bn06jla4nwpqa"),
	preload("uid://dj3roj4jq01yj"),
	preload("uid://4k4qj5evr2ee"),
	preload("uid://cjcg5dft36qqc")
]

var one_piece_music: Array = [
	
]

var jojo_music: Array = [
	preload("uid://b6m7qcc4ydhna"),
	preload("uid://b8d2lg3tlwodh"),
	preload("uid://b5i0ksurxq3i1"),
	preload("uid://c3l0ykefbik5v"),
	preload("uid://cna7ajx1acvgq"),
]

var tv_music: Array = [
	
]

var categories: Array = [
	default_music,
	anime_music,
	one_piece_music,
	jojo_music,
	tv_music
]

func _music_ended() -> void:
	pass

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.bus = &"Music"
	add_child(audio_player)

func play_music(category: int, song: int) -> void:
	print(categories[category][song])
	audio_player.stream = categories[category][song]
	audio_player.play()
	
