extends Node2D

var speed = 200


func set_speed(var spd):
	speed = spd

func _physics_process(delta):
	global_position.y += speed * delta
	if global_position.y >= 1100:
		global_position.y = (-100)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
