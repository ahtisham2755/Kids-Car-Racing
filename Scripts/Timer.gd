extends Node2D

onready var timer = $Timer
onready var coin = preload("res://Scences/Coin.tscn")

var SPEED
var lower_range = 5.0
var upper_range = 9.0

func set_speed(var speed, var TimerCut):
	SPEED = speed
	if (5.0-TimerCut)>1:
		lower_range = 5.0 - TimerCut
	else:
		lower_range = 1
	if (9.0-TimerCut)>2.9:
		upper_range = 9.0 - TimerCut
	else:
		upper_range = 2.9

func get_random_side():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	return rnd.randi_range(0,1)

func get_random_time():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	return rnd.randf_range(lower_range, upper_range)



# Called when the node enters the scene tree for the first time.
func _ready():
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var COIN = coin.instance()
	COIN.set_speed(SPEED)
	var side = get_random_side()
	if side == 0:
		COIN.position.x = 175
	else:
		COIN.position.x = 310
	self.add_child(COIN)
	timer.wait_time = get_random_time()

func start():
	timer.start()

func stop():
	timer.stop()
