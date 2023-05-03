extends RigidBody2D

onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")
onready var jump_timer = $Jump_timer
onready var down_timer = $Down_timer
onready var answer_timer = $Answer_timer

var selected = false
var is_can_up = false
var is_once_down = false
var is_once_picked = false
var is_down = false
func _ready():
	anim_dots.travel("attack1")


func _physics_process(delta):
	rotation_degrees = 0
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false


func _on_Starosta_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and is_can_up == true and is_down == false:
		selected = true
		linear_velocity.y = 0
		is_once_down = true
		is_once_picked = true
		Global.starosta_selfback = true
		jump_timer.stop()
		


func _on_Starosta_body_entered(body):
	if body.name == "Bottom":
		linear_velocity.y = 0
		is_can_up = true
		anim_dots.travel("idle")
		if is_once_down == false:
			jump_timer.start()
			is_once_down = true
	if body.name == "House":
		linear_velocity.y = 0
		is_can_up = false
		anim_dots.travel("attack1")
		if is_once_picked == true:
			down_timer.start()


func _on_Down_timer_timeout():
	linear_velocity.x = -180


func _on_Jump_timer_timeout():
	anim_dots.travel("idle")
	linear_velocity = Vector2(80, -400)
	Global.starosta_selfback = true
	

func down_to_gentle():
	is_down = true
	linear_velocity.x = -250
	jump_timer.wait_time = 20
	jump_timer.start()
	answer_timer.start()
	


func _on_Answer_timer_timeout():
	anim_dots.travel("attack1")
