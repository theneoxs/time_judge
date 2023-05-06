extends RigidBody2D

onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var down_timer = $Down_timer
onready var wait_timer = $Wait_timer

onready var down_sound = $Down

var selected = false
var is_can_up = false
var is_leave = false

func _ready():
	anim_dots.travel("attack1")
	seed(Time.get_unix_time_from_system())
	down_timer.wait_time = rand_range(5, 15)
	down_timer.start()


func _physics_process(delta):
	rotation_degrees = 0
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0
	if is_leave:
		global_position = global_position.linear_interpolate(Vector2(1800, 325), 0.5*delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false


func _on_Man_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and is_can_up and !is_leave:
		selected = true
		linear_velocity.y = 0
		wait_timer.stop()


func _on_Down_timer_timeout():
	linear_velocity.x = 150


func _on_Man_body_entered(body):
	if body.name == "Bottom":
		linear_velocity.y = 0
		if !is_leave:
			is_can_up = true
			anim_dots.travel("death")
			down_timer.stop()
			wait_timer.start()
			down_sound.play()
	if body.name == "House":
		linear_velocity.y = 0
		is_can_up = false
		anim_dots.travel("attack1")
		down_timer.wait_time = rand_range(5, 15)
		down_timer.start()


func _on_Wait_timer_timeout():
	anim_dots.travel("walk")
	is_leave = true
	is_can_up = false
