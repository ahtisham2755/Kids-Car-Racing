extends Node2D


var HomeScreen = preload("res://Scences/HomeScreen.tscn")
var highScore = preload("res://Scences/HighScore.tscn")
var levelScreen = preload("res://Scences/Levels.tscn")
var CarShop = preload("res://Scences/CarShop.tscn")
var PlayScreen = preload("res://Scences/PlayScreen.tscn")
var Settings = preload("res://Scences/Settings.tscn")
onready var music_player = $AudioStreamPlayer

#on index 0 it is the status of music and on index 1 it is the status of sound effects like score crash etc.
var Music_status = [true, true]
const music_file_path = "user://music_status.data"


func update_sound_status(var SoundStatus):
	print("set " + str(SoundStatus))
	Music_status[1] = SoundStatus


func update_music_status(var MusicStatus):
	Music_status[0] = MusicStatus 
	if Music_status[0]:
		music_player.play()
	else:
		music_player.stop()


func _ready():
	LoadHomeScreen(self)

func LoadHomeScreen(var prevScreen):
	#prevScreen contains the instance of prevScreen
	#following 2 lines create instance of scence and add it as child to root node
	var homeScreen = HomeScreen.instance()
	homeScreen.update_music_status(Music_status)
	self.add_child(homeScreen)
	#if prevScreen is not root then delete it by queue free for memory optimization
	if(prevScreen.name != "RootNode"):
		prevScreen.queue_free()
		self.remove_child(prevScreen)

func LoadPlayScreen(var prevScreen):
	#prevScreen contains the instance of prevScreen
	#following 2 lines create instance of scence and add it as child to root node
	var playScreen = PlayScreen.instance()
	playScreen.set_sound_status(Music_status[1])
	self.add_child(playScreen)
	#if prevScreen is not root then delete it by queue free for memory optimization
	if(prevScreen.name != "RootNode"):
		prevScreen.queue_free()
		self.remove_child(prevScreen)

func LoadLevelScreen( var prevScreen):
	#prevScreen contains the instance of prevScreen
	#following 2 lines create instance of scence and add it as child to root node
	var Level_Screen = levelScreen.instance()
	self.add_child(Level_Screen)
	#if prevScreen is not root then delete it by queue free for memory optimization
	if(prevScreen.name != "RootNode"):
		prevScreen.queue_free()
		self.remove_child(prevScreen)


func LoadCarShopScreen(var prevScreen):
	#prevScreen contains the instance of prevScreen
	#following 2 lines create instance of scence and add it as child to root node
	var Car_Shop = CarShop.instance()
	self.add_child(Car_Shop)
	#if prevScreen is not root then delete it by queue free for memory optimization
	if(prevScreen.name != "RootNode"):
		prevScreen.queue_free()
		self.remove_child(prevScreen)

func LoadHighScoreScreen(var prevScreen):
	#prevScreen contains the instance of prevScreen
	#following 2 lines create instance of scence and add it as child to root node
	var HIGHSCORE = highScore.instance()
	self.add_child(HIGHSCORE)
	#if prevScreen is not root then delete it by queue free for memory optimization
	if(prevScreen.name != "RootNode"):
		prevScreen.queue_free()
		self.remove_child(prevScreen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
