extends Node2D

onready var carSprite = $Car_Sprite
onready var select_lable = $button_sprite/select_car_lable
onready var button_sprite = $button_sprite
onready var firework_animator = $firework_animator
onready var firework_sprite = $firework

var curr_car
#selected car index path
const car_index_path = "user://current_car.data"
#all car data file at this path
const cars_data_path = "res://Data/Cars_Data.data"

func set_car(var car_index):
	pass

func Load_All_Cars_Data():
	#returns the array of all cars
	var car = File.new()
	if car.file_exists(cars_data_path):
		car.open(cars_data_path, File.READ)
		var cars_data = car.get_var()
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

# Called when the node enters the scene tree for the first time.
func _ready():
	firework_sprite.show()
	firework_animator.play("firework")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_select_Button_button_up():
	pass # Replace with function body.


func _on_firework_animator_animation_finished(_anim_name):
	firework_sprite.hide()
