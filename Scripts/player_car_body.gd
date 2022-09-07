extends Area2D
class_name player_car_body

onready var animator = $AnimationPlayer

var speed = 400
var road_side = "left"
var button_pressed = false

func get_side():
	return road_side
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("move") && !button_pressed:
		if road_side == "left" :
			road_side = "right"
			animator.play("left_to_right")
		elif road_side == "right":
			road_side = "left"
			animator.play("right_to_left")
	elif button_pressed:
		button_pressed = false
