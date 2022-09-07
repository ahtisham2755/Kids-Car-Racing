extends Area2D
class_name Coin

onready var animator = $AnimationPlayer
onready var firework = $firework
onready var coin = $coin
var SPEED = 150

func set_speed(var speed):
	SPEED = speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += (SPEED) * delta
	if global_position.y >= 900:
		queue_free()


func _on_Coin_area_entered(area):
	if area is player_car_body:
		firework.show()
		coin.hide()
		animator.play("firework")
		SPEED = 0
	else:
		self.modulate = "32ffffff"


func _on_Coin_area_exited(_area):
	self.modulate = "ffffff"


func _on_AnimationPlayer_animation_finished(_anim_name):
	self.queue_free()
