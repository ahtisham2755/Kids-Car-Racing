extends Node2D

onready var strip1 = $Strip
onready var strip2 = $Strip2
onready var strip3 = $Strip3
onready var strip4 = $Strip4
onready var strip5 = $Strip5
onready var strip6 = $Strip6

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func set_speed(var speed):
	strip1.set_speed(speed)
	strip2.set_speed(speed)
	strip3.set_speed(speed)
	strip4.set_speed(speed)
	strip5.set_speed(speed)
	strip6.set_speed(speed)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
