extends Node2D

onready var timer = $Timer
onready var random_car = preload("res://Scences/Opponent_car.tscn")


var car_speed
var all_cars_data = Load_All_Cars_Data()
const cars_data_path = "res://Data/Cars_Data.data"

func Load_All_Cars_Data():
	#returns the array of all cars
	var car = File.new()
	if car.file_exists(cars_data_path):
		car.open(cars_data_path, File.READ)
		var cars_data = car.get_var()
		car.close()
		return cars_data



func get_random_side():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	return rnd.randi_range(0,1)

func get_random_car():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	return rnd.randi_range(1,(all_cars_data.size()-1))

func set_data(var time, var speed):
	timer.wait_time = time
	car_speed = speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var new_car = random_car.instance()
	var side = get_random_side()
	if side == 0:
		new_car.position.x = 175
	else:
		new_car.position.x = 310
	new_car.set_data(get_random_car(), car_speed)
	self.add_child(new_car)

func start():
	timer.start()

func stop():
	timer.stop()


