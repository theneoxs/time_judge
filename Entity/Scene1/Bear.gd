extends KinematicBody2D

var move_mode = 1
var is_attack = false
var is_ran_away = false
var is_moving = false
onready var sprite = $Sprite
onready var anim_tree = $AnimationTree
onready var anim_dots = anim_tree.get("parameters/playback")
onready var timer = $Timer
onready var dead_timer = $Dead_timer

onready var walk_sound_timer = $Walk_sount_timer
onready var sound_walk = $Walk
onready var attack_sound_timer = $Attack_timer
onready var sound_attack = $Attack

var move_vector = Vector2(1, 0)

var is_dead = false

func _ready():
	seed(Time.get_unix_time_from_system())
	
func _on_Bear_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if !is_ran_away and !is_dead:
			flip_anim()
			is_ran_away = true
			timer.stop()
			anim_dots.travel("walk")
			attack_sound_timer.stop()
			walk_sound_timer.start()
			move_vector = move_vector * -2
			Global.count_leave_bear += 1
			collision_layer = 0
			if is_attack:
				Global.bear_is_leave = true

func _physics_process(delta):
	if is_attack:
		timer.stop()
		is_moving = true
		anim_dots.travel("walk")
		collision_mask = 1
	if is_moving or is_ran_away:
		move_and_collide(move_vector)

func _on_Timer_timeout():
	is_moving = false
	if move_mode == 0:
		if is_attack == false:
			move_mode = 1
			anim_dots.travel("idle_right")
			timer.wait_time = rand_range(3, 7)
			walk_sound_timer.stop()
			attack_sound_timer.stop()
	elif move_mode == 1:
		is_moving = true
		move_mode = 0
		anim_dots.travel("walk")
		timer.wait_time = rand_range(1, 2)
		walk_sound_timer.start()

func flip_anim():
	sprite.flip_h = !sprite.flip_h

func attack():
	is_attack = false
	is_ran_away = true
	is_moving = false
	anim_dots.travel("attack")
	attack_sound_timer.start()
	dead_timer.start()


func _on_Dead_timer_timeout():
	attack_sound_timer.stop()
	walk_sound_timer.stop()
	anim_dots.travel("death")
	is_dead = true
	is_ran_away = false
	Global.bear_is_dead = true


func _on_Walk_sount_timer_timeout():
	sound_walk.play()


func _on_Attack_timer_timeout():
	sound_attack.play()
