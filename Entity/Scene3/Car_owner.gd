extends KinematicBody2D

var is_move = true
onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var dead_timer = $Dead_timer
var is_stopped = false

var move_vector = Vector2(1, 0)
var moving_distance = Vector2(0, 0)
var is_back = false

var limit_distance = 400

func _ready():
	anim_dots.travel("walk")

func _physics_process(delta):
	if is_move == true:
		move_and_collide(move_vector)
		moving_distance += move_vector
	if moving_distance.x >= limit_distance and is_back == false:
		if !is_stopped:
			is_move = false
			anim_dots.travel("attack1")
			is_stopped = true


func flip_anim():
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func reverse():
	move_vector *= -1
	is_move = true
	move_and_collide(move_vector)
	is_stopped = false
	anim_dots.travel("walk")
	flip_anim()

