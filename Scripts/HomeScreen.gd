extends Node2D

onready var music = $MusicOff/music_on
onready var sound = $sound_off/sound_on
onready var player_car = $player_car
onready var total_coins_lbl = $total_coins/total_coins_lbl
onready var parentNode = get_parent()

#variables used in code
const total_coins_path = "user://total_coins.data"
#on index 0 it is the status of music and on index 1 it is the status of sound effects like score crash etc.
var music_status = [true, true]

func update_music_status(var status):
	music_status = status

func update_coins_lable():
	total_coins_lbl.text = str(get_total_coins())

func get_total_coins():
	var coin_file = File.new()
	if coin_file.file_exists(total_coins_path):
		coin_file.open(total_coins_path, File.READ)
		var total_coins = coin_file.get_var()
		coin_file.close()
		return total_coins
	else:
		return 0

# Called when the node enters the scene tree for the first time.
func _ready():
	total_coins_lbl.text = str(get_total_coins())
	if music_status[0]:
		music.visible = true
	else:
		music.visible = false
	if music_status[1]:
		sound.visible = true
	else:
		sound.visible = false

func _on_Play_button_up():
	parentNode.LoadPlayScreen(self)

func _on_music_btn_button_up():
	if music.visible == true:
		music.visible = false
		parentNode.update_music_status(false)
	else:
		parentNode.update_music_status(true)
		music.visible = true

func _on_sound_btn_button_up():
	if sound.visible == true:
		sound.visible = false
		parentNode.update_sound_status(false)
	else:
		sound.visible = true
		parentNode.update_sound_status(true)

func _on_shop_btn_button_up():
	parentNode.LoadCarShopScreen(self)

func _on_highscore_btn_button_up():
	parentNode.LoadHighScoreScreen(self)

func _on_level_btn_button_up():
	parentNode.LoadLevelScreen(self)
