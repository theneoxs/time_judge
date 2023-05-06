extends RigidBody2D

var selected = false

func _ready():
	seed(Time.get_unix_time_from_system())
	linear_velocity.x = rand_range(70, 150)
	$Create.play()

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false


func _on_Trash_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		linear_velocity.y = 0
		linear_velocity.x = 0


func _on_Trash_body_entered(body):
	if body.name == "Trash_can":
		Global.play_trash()
		Global.count_trash -= 1
		queue_free()
