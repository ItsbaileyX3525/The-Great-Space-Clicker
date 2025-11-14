extends Node

var audio_player: AudioStreamPlayer

var clicks: Array = [
	preload("uid://cbykemfbxv3ti"),
	preload("uid://dcmq3dd4yk5kw"),
	preload("uid://5ljnl4lou757"),
	preload("uid://dkg5j08sdp7ut")
]

var default_music: Array = [
	preload("uid://eu5llovvit86"),
	preload("uid://clcurn17r0kq1"),
	preload("uid://cjb81wq071ust"),
	preload("uid://cx33kldu48eqe"),
	preload("uid://bf31l6mns8g4t"),
]

var anime_music: Array = [
	preload("uid://c0u1loar0xr52"),
	preload("uid://bn06jla4nwpqa"),
	preload("uid://dj3roj4jq01yj"),
	preload("uid://4k4qj5evr2ee"),
	preload("uid://cjcg5dft36qqc")
]

var one_piece_music: Array = [
	preload("uid://wqptgqt52ot8"), #We Are
	preload("uid://488ypg3uxi1r"), #All of us
	preload("uid://0olwlbjqamfu"), #The peak
	preload("uid://di4m1jbdf1tqe"), #Raise
	preload("uid://205y0ylbiac5"), #Punks
]

var jojo_music: Array = [
	preload("uid://b6m7qcc4ydhna"),
	preload("uid://b8d2lg3tlwodh"),
	preload("uid://b5i0ksurxq3i1"),
	preload("uid://c3l0ykefbik5v"),
	preload("uid://cna7ajx1acvgq"),
]

var tv_music: Array = [
	preload("uid://bgem1kl1dxp2h"), #tbbt
	preload("uid://l8dl1svyk83w"), #b99
	preload("uid://cn4qs2cvlc0oe"), #fnd
	preload("uid://dk20n4ysi7j4k"), #bb
	preload("uid://7wueplndw52u"), #dexter
]

var secret_music: Array = [
	preload("uid://b1jv0mlfwgsa5"),
	preload("uid://7v705jmpqtl5"),
	preload("uid://4pkccl6f5egb"),
]

var categories: Array = [
	default_music,
	anime_music,
	one_piece_music,
	jojo_music,
	tv_music,
	secret_music,
]

func _music_ended() -> void:
	audio_player.play()

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.bus = &"Music"
	audio_player.connect("finished", _music_ended)
	add_child(audio_player)

func play_music(category: int, song: int) -> void:
	print(categories[category][song])
	audio_player.stream = categories[category][song]
	audio_player.play()

func remove_click(audio: AudioStreamPlayer) -> void:
	audio.call_deferred("queue_free")

func play_click() -> void:
	var click = AudioStreamPlayer.new()
	click.stream = clicks[Settings.current_save["clickSound"]]
	click.bus = &"SFX"
	click.connect(
		"finished",
		Callable(self, "remove_click").bind(click)
	)
	add_child(click)
	click.play()
