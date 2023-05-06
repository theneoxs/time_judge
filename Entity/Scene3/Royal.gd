extends RigidBody2D

var selected = false
var is_selected = false

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0
	if position.x < -340 or position.x > 420 or position.y < -120 or position.y > 250:
		queue_free()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false


func _on_Royal_body_entered(body):
	if body.name == "Car" and !is_selected:
		Global.car_crashed = true
		body.alarm()
	if body.name == "Trash_can":
		queue_free()


func _on_Royal_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		is_selected = true
		selected = true
		linear_velocity.y = 0
		linear_velocity.x = 0
