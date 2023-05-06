extends KinematicBody2D

var thing = load("res://Entity/Scene4/Thing.tscn")

var is_move = true
onready var sprites = $AnimationTree
onready var anim_sprites = $AnimatedSprite
onready var anim_dots = sprites.get("parameters/playback")
onready var wait_timer = $Wait_timer
onready var throw_timer = $Throw_timer
var is_stopped = false

var move_vector = Vector2(2, 0)
var moving_distance = Vector2(0, 0)

func _ready():
	seed(Time.get_unix_time_from_system())
	anim_dots.travel("walk")

func _physics_process(delta):
	if is_move == true and is_stopped == false:
		move_and_collide(move_vector)
		moving_distance.x += abs(move_vector.x)
	if abs(moving_distance.x) >= 800:
		queue_free()

func flip_anim():
	anim_sprites.flip_h = !anim_sprites.flip_h
	move_vector *= -1
	if anim_sprites.position.x > 0:
		anim_sprites.position.x = -22
	else:
		anim_sprites.position.x = 19

func brake():
	if is_stopped == false:
		is_move = false
		anim_dots.travel("death")

func _on_Cyborg_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and is_move == false:
		anim_dots.travel("idle")
		wait_timer.start()
		Global.cyborg_repait += 1
		

func _on_Brake_timer_timeout():
	if rand_range(0, 100) > 95:
		brake()


func _on_Wait_timer_timeout():
	is_move = true
	anim_dots.travel("walk")

func stand_ready():
	is_stopped = true
	anim_dots.travel("idle")
	if move_vector.x > 0:
		flip_anim()
	throw_timer.start()


func _on_Throw_timer_timeout():
	if !get_parent().has_node("Thing"):
		var new_thing = thing.instance()
		get_parent().add_child(new_thing)
		new_thing.global_position = global_position
		new_thing.linear_velocity = Vector2(-150, -300)
		Global.is_throw_item = true
		$Throw.play()
	is_stopped = false
	anim_dots.travel("walk")
