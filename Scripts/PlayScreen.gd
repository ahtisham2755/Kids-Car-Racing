extends Node2D

onready var score_sound = $Score_Sound
onready var car_hit_sound = $Car_hit_sound
onready var parent_node = self.get_parent()
onready var gameover_statement = $GameOver/statement_lable
onready var gameover_score = $GameOver/Score_sprite/Label
onready var roadStrips = $RoadStrips 
onready var exit_confirmation = $exit_confirmation
onready var play_sprite = $Pause_sprite/Play_sprite
onready var player_car = $player_car_body/player_car
onready var player_car_body = $player_car_body
onready var car_spawner = $car_spawner
onready var pause_sprite = $Pause_sprite
onready var hit_car = $hit_car
onready var animator = $hit_car/AnimationPlayer
onready var coin_spawner = $Coin_spawner
onready var gameOver = $GameOver
onready var score_lable = $Score/score_lable

var sound_staus = true
var score = 0
var paused_status = false
var player_car_index = 1
var all_cars_data
var Gen_Speed = 200
var Car_Speed = 250
var TimerCut = 0
const total_coins_path = "user://total_coins.data"
const cars_data_path = "res://Data/Cars_Data.data"
const save_level_path = "user://level.data"
const car_index_path = "user://current_car.data"
const highscore_path = "user://highscore.data"

func set_sound_status(var status):
	sound_staus = status

func Load_Selected_Car():
	#return the index of current car in array of all cars
	var car = File.new()
	if car.file_exists(car_index_path):
		car.open(car_index_path, File.READ)
		var car_index = car.get_var()
		car.close()
		return car_index
	else:
		#if game is opened first time them it is first car by default
		car.open(car_index_path, File.WRITE)
		car.store_var(1)
		car.close()
		return 1

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

func set_speed( var gen_speed, var car_speed, var timer_cut):
	var level = Load_Current_Level()
	if level == 1:
		roadStrips.set_speed(gen_speed)
		coin_spawner.set_speed(gen_speed, timer_cut)
		car_spawner.set_data(7.0-timer_cut, car_speed)
	elif level == 2:
		roadStrips.set_speed(gen_speed+200)
		coin_spawner.set_speed(gen_speed+200, timer_cut)
		car_spawner.set_data(6.0-timer_cut, car_speed+200)
	elif level == 3:
		roadStrips.set_speed(gen_speed+350) 
		coin_spawner.set_speed(gen_speed+350, timer_cut)
		car_spawner.set_data(5.0-timer_cut, car_speed+350)
	elif level == 4:
		roadStrips.set_speed(gen_speed+550)
		coin_spawner.set_speed(gen_speed+550, timer_cut)
		car_spawner.set_data(4-timer_cut, car_speed+500)
	elif level == 5:
		roadStrips.set_speed(gen_speed+900)
		coin_spawner.set_speed(gen_speed+900, timer_cut)
		car_spawner.set_data(3.5-timer_cut, car_speed+700)

func Load_All_Cars_Data():
	#returns the array of all cars
	var car = File.new()
	if car.file_exists(cars_data_path):
		car.open(cars_data_path, File.READ)
		var cars_data = car.get_var()
		car.close()
		return cars_data

func load_highscore():
	#return the array of size 5 i.e. five high scores
	var highscore = [0,  0, 0, 0, 0] 
	var score_file = File.new()
	if score_file.file_exists(highscore_path):
		score_file.open(highscore_path, File.READ)
		highscore = score_file.get_var()
		score_file.close()
		return highscore
	else:
		#if game is opened first time them it is all zeros by default
		score_file.open(highscore_path, File.WRITE)
		score_file.store_var(highscore)
		score_file.close()
		return highscore

func save_highscore(var current_score):
#	#save the array of size 5 i.e. five high scores
	var if_highscore = false
	var highscore = load_highscore()
	# do only 5 iterations because we store only top 5 scores
	for x in 5:
		#checking if current score is highscore
		if current_score >= highscore[x]:
			if_highscore = true
			#if highscore found then shift lower score than current score to next index so new can be place 
			# reverse loop i.e. runs like 4,3,2,1 etc
			for index in range(4,x,-1):
				highscore[index] = highscore[index-1]
			highscore[x] = current_score
			# as now highscore array is updated so storing updated array to file
			var score_file = File.new()
			score_file.open(highscore_path, File.WRITE)
			highscore = score_file.store_var(highscore)
			score_file.close()
			# when highscore found and updated no need to go further so breaking main loop by return
			return if_highscore
	return if_highscore

func update_total_coins(var coins):
	var coin_file = File.new()
	if coin_file.file_exists(total_coins_path):
		coin_file.open(total_coins_path, File.READ)
		var total_coins = coin_file.get_var()
		total_coins = total_coins + coins
		coin_file.open(total_coins_path,File.WRITE)
		coin_file.store_var(total_coins)
		coin_file.close()
	else:
		coin_file.open(total_coins_path, File.WRITE)
		coin_file.store_var(coins)
		coin_file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	all_cars_data = Load_All_Cars_Data()
	player_car_index = Load_Selected_Car()
	player_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[player_car_index][0]) + ".png")
	set_speed(200, 250, 0)
	car_spawner.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_back_Btn_button_down():
	player_car_body.button_pressed = true
	get_tree().paused = true
	exit_confirmation.show()

func _on_Play_Pause_btn_button_down():
	player_car_body.button_pressed = true
	if paused_status == false:
		paused_status = true
		get_tree().paused = true
		#as above line freez pause btn too so before doing it set pause mode of btn to process in the inspector
		play_sprite.show()
	else:
		paused_status = false
		get_tree().paused = false
		play_sprite.hide()

func _on_yes_btn_button_up():
	get_tree().paused = false
	update_total_coins(score)
	save_highscore(score)
	parent_node.LoadHomeScreen(self)

func _on_no_btn_button_up():
	if paused_status == false:
		get_tree().paused = false
	exit_confirmation.hide()

func _on_player_car_body_area_entered(area):
	if area is Opponent_car:
		if sound_staus:
			car_hit_sound.play()
		pause_sprite.hide()
		var is_highscore = save_highscore(score)
		update_total_coins(score)
		if is_highscore:
			gameover_statement.text = "H I G H S C O R E"
		else:
			gameover_statement.text = "Your Score is"
		gameover_score.text = str(score)
		if area.has_method("get_texture"):
			hit_car.texture = area.get_texture()
			area.hide()
			hit_car.show()
			if area.get_x_position() == 175:
				animator.play("left car hit")
			elif area.get_x_position() == 310:
				animator.play("right car hit")
		get_tree().paused = true
	elif area is Coin:
		if sound_staus:
			score_sound.play()
		score += 1
		score_lable.text = str(score)


func _on_Play_btn_button_up():
	get_tree().paused = false
	parent_node.LoadPlayScreen(self)


func _on_Home_btn_button_up():
	get_tree().paused = false
	parent_node.LoadHomeScreen(self)


func _on_AnimationPlayer_animation_finished(_anim_name):
	gameOver.show()


func _on_Timer_timeout():
	Gen_Speed = Gen_Speed + 15
	Car_Speed = Car_Speed + 15
	TimerCut = TimerCut + 0.075
	set_speed(Gen_Speed, Car_Speed, TimerCut)
