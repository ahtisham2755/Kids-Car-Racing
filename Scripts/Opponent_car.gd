extends Area2D
class_name Opponent_car

onready var car = $car
var SPEED = 100

var car_index = 1

func get_x_position():
	return position.x

func get_texture():
	return car.texture

func set_data(var index, var speed):
	car_index = index
	SPEED = speed

# Called when the node enters the scene tree for the first time.
func _ready():
	car.texture = load("res://Sprites/cars/car_" + str(car_index) + ".png")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += (SPEED) * delta
	if global_position.y >= 900:
		queue_free()
