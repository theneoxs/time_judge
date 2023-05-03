extends RigidBody2D

onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var down_timer = $Down_timer

var selected = false
var is_can_up = false
var is_leave = false

func _ready():
	anim_dots.travel("idle")
	seed(Time.get_unix_time_from_system())
	down_timer.wait_time = Global.DOWN_PIANO
	down_timer.start()


func _physics_process(delta):
	rotation_degrees = 0


func _on_Down_timer_timeout():
	if Global.count_trash <= 8:
		linear_velocity.x = 175
	else:
		linear_velocity.x = -250
		linear_velocity.y = -200
	anim_dots.travel("death")


func _on_Header_body_entered(body):
	pass
