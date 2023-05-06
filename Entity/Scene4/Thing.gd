extends RigidBody2D

onready var clear_timer = $Clear_timer
var selected = false
var movable = false

var movement = 0

func _physics_process(delta):
	if selected:
		modulate.a = lerp(modulate.a, 0, 0.5*delta)
	if movable:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0
	if get_parent().get_node("Thing").position.x <= -400:
		queue_free()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			movable = false

func check_pass():
	selected = true
	movable = false
	clear_timer.start()
	linear_velocity = Vector2(0, 0)
	gravity_scale = 0

func _on_Clear_timer_timeout():
	queue_free()


func _on_Thing_body_entered(body):
	if body.name == "Car_owner":
		Global.item_is_picked = true
		body.reverse()
		queue_free()


func _on_Thing_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		movable = true
		linear_velocity.y = 0
		linear_velocity.x = 0
