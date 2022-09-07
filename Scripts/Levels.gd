extends Node2D

onready var selected_sprite = $selected_sprite
onready var selected_sprite_lbl = $selected_sprite/Label6
onready var parentNode = get_parent()

# variables used in code
var save_level_path = "user://level.data"

func Load_Current_Level():
	#return the value of level i.e. 1,2,3,4,5 in integer
	var level = File.new()
	if level.file_exists(save_level_path):
		level.open(save_level_path, File.READ)
		var current_level = level.get_var()
		level.close()
		return current_level
	else:
		#if game is opened first time them it is very easy level by default
		level.open(save_level_path, File.WRITE)
		level.store_var(1)
		level.close()
		return 1

func Save_Current_Level(var current_level):
	# save the index of current car to file
	var level = File.new()
	level.open(save_level_path, File.WRITE)
	level.store_var(current_level)
	level.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_level = Load_Current_Level()
	if current_level == 1:
		selected_sprite.position.y = 235
		selected_sprite_lbl.text = "V e r y   E a s y"
	elif current_level == 2:
		selected_sprite.position.y = 335
		selected_sprite_lbl.text = "E a s y"
	elif current_level == 3:
		selected_sprite.position.y = 435
		selected_sprite_lbl.text = "N o r m a l"
	elif current_level == 4:
		selected_sprite.position.y = 535
		selected_sprite_lbl.text = "H a r d"
	elif current_level == 5:
		selected_sprite.position.y = 635
		selected_sprite_lbl.text = "V e r y   H a r d"
	selected_sprite.position.x = 240
	selected_sprite.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_back_Btn_button_up():
	parentNode.LoadHomeScreen(self)

func _on_very_easy_btn_button_up():
	Save_Current_Level(1)
	selected_sprite.position.x = 240
	selected_sprite.position.y = 235
	selected_sprite_lbl.text = "V e r y   E a s y"
	selected_sprite.show()

func _on_easy_btn_button_up():
	Save_Current_Level(2)
	selected_sprite.position.x = 240
	selected_sprite.position.y = 335
	selected_sprite_lbl.text = "E a s y"
	selected_sprite.show()

func _on_normal_btn_button_up():
	Save_Current_Level(3)
	selected_sprite.position.x = 240
	selected_sprite.position.y = 435
	selected_sprite_lbl.text = "N o r m a l"
	selected_sprite.show()

func _on_hard_btn_button_up():
	Save_Current_Level(4)
	selected_sprite.position.x = 240
	selected_sprite.position.y = 535
	selected_sprite_lbl.text = "H a r d"
	selected_sprite.show()

func _on_very_hard_btn_button_up():
	Save_Current_Level(5)
	selected_sprite.position.x = 240
	selected_sprite.position.y = 635
	selected_sprite_lbl.text = "V e r y   H a r d"
	selected_sprite.show()
