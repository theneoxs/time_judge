extends KinematicBody2D

var is_move = true
onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var dead_timer = $Dead_timer
var is_stopped = false

var move_vector = Vector2(1, 0)
var moving_distance = Vector2(0, 0)
onready var wait_after_come = $Wait_after_come
onready var made_a_deal_timer = $Made_a_deal
var is_back = false

var is_next = false

var limit_distance = 150

func _ready():
	anim_dots.travel("walk")

func _physics_process(delta):
	if is_move == true:
		move_and_collide(move_vector)
		moving_distance += move_vector
	if moving_distance.x >= limit_distance and is_back == false and is_next == false:
		if !is_stopped:
			is_move = false
			anim_dots.travel("idle")
			is_stopped = true
			wait_after_come.start()
	if is_next == true and moving_distance.x >= limit_distance*3 and is_back == false:
		if !is_stopped:
			is_move = false
			anim_dots.travel("attack1")
			is_stopped = true
			made_a_deal_timer.start()


func flip_anim():
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h


func _on_Wait_after_come_timeout():
	if Global.count_villager >= 2 and Global.starosta_selfback:
		is_next = true
		is_stopped = false
		is_move = true
		anim_dots.travel("walk")
	else:
		is_back = true
		is_stopped = false
		is_move = true
		anim_dots.travel("walk")
		flip_anim()
		move_vector *= -1
		move_and_collide(move_vector)
		Global.gentleman_leave = true


func _on_Made_a_deal_timeout():
	is_back = true
	is_stopped = false
	is_move = true
	anim_dots.travel("walk")
	flip_anim()
	move_vector *= -1
	move_and_collide(move_vector)
	Global.gentleman_leave = true
