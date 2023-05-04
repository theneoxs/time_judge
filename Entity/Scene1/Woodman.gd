extends KinematicBody2D

var is_move = true
onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var dead_timer = $Dead_timer
var is_stopped = false

var move_vector = Vector2(1, 0)
var moving_distance = Vector2(0, 0)
onready var wait_after_kill = $Wait_after_kill
var is_back = false

var limit_distance = 600

func _ready():
	anim_dots.travel("walk")

func _physics_process(delta):
	if is_move == true:
		move_and_collide(move_vector)
		moving_distance += move_vector
	if moving_distance.x >= limit_distance and is_back == false:
		if !is_stopped:
			is_move = false
			anim_dots.travel("idle")
			is_stopped = true
			collision_layer = 1
			collision_mask = 1
			if limit_distance != 300:
				anim_dots.travel("attack1")
				dead_timer.start()
	if Global.bear_is_leave == true and is_back == false:
		_on_Wait_after_kill_timeout()


func _on_Area2D_body_entered(body):
	if body.name == "Bear" and Global.bear_is_dead == false:
		if body.is_attack == true:
			body.attack()
			anim_dots.travel("attack1")
			dead_timer.start()


func _on_Dead_timer_timeout():
	anim_dots.travel("idle")
	wait_after_kill.start()
	$Area2D/CollisionShape2D.disabled = true


func _on_Wait_after_kill_timeout():
	Global.is_first_woodman = true
	is_back = true
	is_stopped = false
	is_move = true
	anim_dots.travel("walk")
	flip_anim()
	move_vector *= -1
	move_and_collide(move_vector)
	collision_layer = 0
	collision_mask = 0

func flip_anim():
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h


func _on_Woodman_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and is_back == false and Global.is_first_woodman == true:
		_on_Wait_after_kill_timeout()
