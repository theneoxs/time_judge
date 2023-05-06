extends RigidBody2D

onready var clear_timer = $Clear_timer
var selected = false

var movement = 0

func _physics_process(delta):
	if selected:
		modulate.a = lerp(modulate.a, 0, 0.5*delta)
	if get_parent().get_node("Thing").position.x <= 400:
		queue_free()

func check_pass():
	selected = true
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
