extends Node2D

onready var ParentNode = get_parent()
onready var score1 = $background_box/score_1/Label
onready var score2 = $background_box/score_2/Label2
onready var score3 = $background_box/score_3/Label3
onready var score4 = $background_box/score_4/Label4
onready var score5 = $background_box/score_5/Label5

var highscore = [0, 0, 0, 0, 0]
const highscore_path = "user://highscore.data"

#dependent functions

func load_highscore():
	#return the array of size 5 i.e. five high scores
	var HighScore = [0,  0, 0, 0, 0] 
	var score_file = File.new()
	if score_file.file_exists(highscore_path):
		score_file.open(highscore_path, File.READ)
		HighScore = score_file.get_var()
		score_file.close()
		return HighScore
	else:
		#if game is opened first time them it is all zeros by default
		score_file.open(highscore_path, File.WRITE)
		score_file.store_var(HighScore)
		score_file.close()
		return HighScore

# Called when the node enters the scene tree for the first time.
func _ready():
	highscore = load_highscore()
	if highscore.size() == 5:
		score1.text = str(highscore[0])
		score2.text = str(highscore[1])
		score3.text = str(highscore[2])
		score4.text = str(highscore[3])
		score5.text = str(highscore[4])
	else:
		score1.text = "0"
		score2.text = "0"
		score3.text = "0"
		score4.text = "0"
		score5.text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_Btn_button_up():
	ParentNode.LoadHomeScreen(self)
