extends Node2D

var bear = load("res://Entity/Scene1/Bear.tscn")
var woodman = load("res://Entity/Scene1/Woodman.tscn")

var bear_now = null
var woodman_now = null

var woodman_alive = false

onready var bear_timer = $Bear_spawn_timer
onready var woodman_timer = $Woodman_spawn_timer

func _ready():
	woodman_timer.wait_time = Global.WAIT_WOODCUTTER
	seed(Time.get_unix_time_from_system())
	spawn_bear()

func _physics_process(delta):
	if bear_now != null:
		if bear_now.position.x <= -500 or bear_now.position.x >= 500:
			bear_now.queue_free()
			bear_now = null
			bear_timer.start()
	if woodman_now != null:
		if woodman_now.position.x <= -400 and woodman_now.is_back == true:
			woodman_now.queue_free()
			woodman_now = null
			if Global.bear_is_dead:
				woodman_timer.start()
				woodman_timer.wait_time = 5
			

func spawn_bear(pos = 0):
	bear_now = bear.instance()
	add_child(bear_now)
	var random_pos = 4
	if pos == 0:
		random_pos = int(rand_range(1, 4))
	bear_now.global_position = get_node("Spawnpoints/Pos" + str(random_pos)).global_position
	bear_now.scale = Vector2(5, 5)
	if random_pos >= 1 and random_pos <= 2:
		bear_now.move_vector = Vector2(1, 0)
	else:
		bear_now.move_vector = Vector2(-1, 0)
		bear_now.flip_anim()
	if pos != 0:
		bear_now.is_attack = true


func _on_Bear_spawn_timer_timeout():
	if woodman_alive and !Global.bear_is_leave:
		spawn_bear(1)
	else:
		spawn_bear(0)


func _on_Woodman_spawn_timer_timeout():
	woodman_alive = true
	woodman_now = woodman.instance()
	add_child(woodman_now)
	woodman_now.scale = Vector2(2, 2)
	var random_pos = 2
	if !Global.bear_is_dead:
		woodman_now.limit_distance = 300
	else:
		random_pos = int(rand_range(1, 4))
	woodman_now.global_position = get_node("Spawnpoints/Pos" + str(random_pos)).global_position
	if random_pos >= 1 and random_pos <= 2:
		woodman_now.move_vector = Vector2(1, 0)
	else:
		woodman_now.move_vector = Vector2(-1, 0)
		woodman_now.flip_anim()
