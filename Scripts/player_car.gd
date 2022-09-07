extends Node2D

onready var parentnode = get_parent()
onready var screen_car_animator = $Screen_car_animator
onready var side_car_animator = $Side_car_animator
onready var screen_car = $Screen_car
onready var screen_car_lock = $Screen_car/lock
onready var left_car = $LeftSide_car
onready var left_car_lock = $LeftSide_car/lock
onready var right_car = $RightSide_car
onready var right_car_lock = $RightSide_car/lock
onready var end_right_btn = $move_car_right/right_side_end
onready var end_left_btn = $move_car_left/left_side_end
onready var selected_sprite = $select_car/selected_sprite
onready var locked_sprite = $select_car/locked_sprite
onready var select_car_lbl = $select_car/select_car_lable
onready var car_price = $select_car/locked_sprite/car_price
onready var unlock_status = $unlock_status
onready var unlock_status_animator = $unlock_status_animator
onready var firework = $firework
onready var firework_animator = $firework_animator


#variables used in code
const res_cars_data_path = "res://Data/Cars_Data.data"
const car_index_path = "user://current_car.data"
const user_cars_data_path = "user://Cars_Data.data"
const total_coins_path = "user://total_coins.data"
# user may press move car button more than one before animation finish, it skip cars so to prevent it
var animation_finished = true
#selected car is car which user chose to play while current car is car shown on screen while scrolling
var selected_car  = 1
var current_car = 1
var all_cars_data

#dependent functions
func update_coins_lable():
	parentnode.update_coins_lable()

func update_total_coins(var coins):
	var coin_file = File.new()
	coin_file.open(total_coins_path, File.WRITE)
	coin_file.store_var(coins)
	coin_file.close()

func get_total_coins():
	var coin_file = File.new()
	if coin_file.file_exists(total_coins_path):
		coin_file.open(total_coins_path, File.READ)
		var total_coins = coin_file.get_var()
		coin_file.close()
		return total_coins
	else:
		return 0

# this func is for parent node to get current car value
func Current_Car():
	return current_car

func Update_All_Cars_Data(var data):
	var cars_data = File.new()
	cars_data.open(user_cars_data_path, File.WRITE)
	cars_data.store_var(data)
	cars_data.close()

func Load_All_Cars_Data():
	#returns the array of all cars
	var car = File.new()
	if car.file_exists(user_cars_data_path):
		car.open(user_cars_data_path, File.READ)
		var cars_data = car.get_var()
		car.close()
		return cars_data
	else:
		car.open(res_cars_data_path, File.READ)
		var cars_data = car.get_var()
		car.open(user_cars_data_path, File.WRITE)
		car.store_var(cars_data)
		car.close()
		return cars_data

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

func Save_Selected_car(var CarIndex):
	# save the index of current car to file
	var car = File.new()
	car.open(car_index_path, File.WRITE)
	car.store_var(CarIndex)
	car.close()



# Called when the node enters the scene tree for the first time.
func _ready():
#	Save_Selected_car(2)
#	SaveCars()
	selected_car = Load_Selected_Car()
	current_car = selected_car
	if current_car == selected_car:
		selected_sprite.show()
		select_car_lbl.text = "S E L E C T E D"
	all_cars_data = Load_All_Cars_Data()
	screen_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car][0]) + ".png")
	screen_car.scale.x = 1
	screen_car.scale.y = 1
	if current_car > 1:
		left_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car-1][0]) + ".png")
		if all_cars_data[current_car-1][1]:
			left_car_lock.hide()
		else:
			left_car_lock.show()
	else:
		end_left_btn.show()
	if current_car < all_cars_data[0]:
		right_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car+1][0]) + ".png")
		if all_cars_data[current_car+1][1]:
			right_car_lock.hide()
		else:
			right_car_lock.show()
	else:
		end_right_btn.show()

func move_cars(var To_Side):
	# code to moves cars right  to left i.e. <----
	if To_Side == "RightToLeft" && current_car < all_cars_data[0]:
		if animation_finished:
			current_car += 1
		side_car_animator.play("right_car_to_screen")
		screen_car_animator.play("screen_car_to_left")
		animation_finished = false
	# code to moves cars left to right i.e. ---->
	elif To_Side == "LeftToRight" && current_car > 1:
		if animation_finished:
			current_car -= 1 
		side_car_animator.play("left_car_to_screen")
		screen_car_animator.play("screen_car_to_right")
		animation_finished = false
	if current_car == selected_car && all_cars_data[current_car][1]:
		selected_sprite.show()
		locked_sprite.hide()
		select_car_lbl.text = "S E L E C T E D"
	elif all_cars_data[current_car][1]:
		selected_sprite.hide()
		locked_sprite.hide()
		select_car_lbl.text = "S E L E C T   C A R"
	else:
		locked_sprite.show()
		car_price.text = "$ " + str(all_cars_data[current_car][2])
		select_car_lbl.text = "U N L O C K"

func _on_Side_car_animator_animation_finished(anim_name):
	if anim_name == "left_car_to_screen": 
		left_car.position.x = -120
		right_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car+1][0]) + ".png")
		if all_cars_data[current_car+1][1]:
			right_car_lock.hide()
		else:
			right_car_lock.show()
		if current_car > 1:
			left_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car-1][0]) + ".png")
			if all_cars_data[current_car-1][1]:
				left_car_lock.hide()
			else:
				left_car_lock.show()
	elif anim_name == "right_car_to_screen":
		right_car.position.x = 600
		left_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car-1][0]) + ".png")
		if all_cars_data[current_car-1][1]:
				left_car_lock.hide()
		else:
				left_car_lock.show()
		if current_car < (all_cars_data[0]):
			right_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car+1][0]) + ".png")
			if all_cars_data[current_car+1][1]:
				right_car_lock.hide()
			else:
				right_car_lock.show()

func _on_Screen_car_animator_animation_finished(_anim_name):
	screen_car.texture = load("res://Sprites/cars/car_" + str(all_cars_data[current_car][0]) + ".png")
	# checking if car is locked or not
	if all_cars_data[current_car][1]:
		screen_car_lock.hide()
	else:
		screen_car_lock.show()
	# in animation screen car go to side so resetting its position and scales
	screen_car.scale.x = 1
	screen_car.scale.y = 1
	screen_car.position.x = 240
	animation_finished = true

func _on_move_car_right_btn_button_up():
	move_cars("RightToLeft")
	if current_car == all_cars_data[0]:
		end_right_btn.show()
	else:
		end_right_btn.hide()
		if current_car != 1:
			end_left_btn.hide()

func _on_move_car_left_btn_button_up():
	move_cars("LeftToRight")
	if current_car == 1:
		end_left_btn.show()
	else:
		end_left_btn.hide()
		if current_car != all_cars_data[0]:
			end_right_btn.hide()

func _on_select_car_btn_button_up():
	if select_car_lbl.text == "S E L E C T   C A R" :
		selected_car = current_car
		Save_Selected_car(selected_car)
		selected_sprite.show()
		select_car_lbl.text = "S E L E C T E D"
	elif select_car_lbl.text == "U N L O C K":
		var total_coins = get_total_coins()
		if total_coins >= all_cars_data[current_car][2]:
			select_car_lbl.text = "S E L E C T   C A R"
			screen_car_lock.hide()
			selected_sprite.hide()
			locked_sprite.hide()
			all_cars_data[current_car][1] = true
			update_total_coins(total_coins-all_cars_data[current_car][2])
			update_coins_lable()
			Update_All_Cars_Data(all_cars_data)
			unlock_status.add_color_override("font_color", "625959")
			firework.show()
			firework_animator.play("firework")
			unlock_status.text = "Unlocked"
			unlock_status.show()
			unlock_status_animator.play("not_enough_money")
		else:
			unlock_status.add_color_override("font_color", "e32828")
			unlock_status.text = "Not Enough Money"
			unlock_status.show()
			unlock_status_animator.play("not_enough_money")


func _on_unlock_status_animator_animation_finished(anim_name):
	if anim_name == "not_enough_money":
		unlock_status_animator.play("RESET")
		unlock_status.hide()


func _on_firework_animator_animation_finished(_anim_name):
	firework.hide()
