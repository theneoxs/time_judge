extends Area2D

var current_portal = false
onready var clear_timer = $Clear_timer
var clear_portal = false

func _ready():
	$Create.play()
	scale = Vector2(0.5, 0.5)

func _physics_process(delta):
	if !current_portal:
		scale.x = lerp(scale.x, 2, 0.5*delta)
		scale.y = lerp(scale.y, 2, 0.5*delta)
		if scale.x >= 1.5:
			queue_free()
	else:
		scale = Vector2(1, 1)
	if clear_portal:
		modulate.a = lerp(modulate.a, 0, 0.33*delta)

func _on_Portal_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if !current_portal:
			Global.closing_portal += 1
		queue_free()

func make_current():
	current_portal = true
	modulate = Color(0.7, 0.8, 1)

func make_exit_portal():
	current_portal = true
	collision_layer = 0
	collision_mask = 0
	modulate = Color(0.7, 0.8, 1)
	clear_timer.start()

func _on_Portal_body_entered(body):
	if body.name == "Thing" and current_portal:
		clear_timer.start()
		clear_portal = true
		Global.item_sending = true
		body.check_pass()
		get_parent().place_cyborg.set_deferred("monitorable", false)
		get_parent().place_cyborg.set_deferred("monitoring", false)


func _on_Clear_timer_timeout():
	queue_free()
