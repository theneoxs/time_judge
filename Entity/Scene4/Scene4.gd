extends Node2D

var portal = load("res://Entity/Scene4/Portal.tscn")
var cyborg = load("res://Entity/Scene4/Cyborg.tscn")

var count_portal = 0
var spawn_core_portal = false

onready var last_portal_point = $Last_portal_point
onready var point_portal = $Path2D/Point_portal
onready var place_cyborg = $Place_cyborg
onready var cyborg_spawn_timer = $Cyborg_spawn_timer
onready var spawn_portal = $Spawn_portal
onready var pos_list = [$Cyborg_place/Point1, $Cyborg_place/Point2, $Cyborg_place/Point3, $Cyborg_place/Point4]

func _ready():
	seed(Time.get_unix_time_from_system())
	cyborg_spawn_timer.wait_time = Global.TIME_CREATE_CYBORG
	spawn_portal.wait_time = Global.TIME_CREATE_PORTAL
	cyborg_spawn_timer.start()
	spawn_portal.start()
	

func _on_Spawn_portal_timeout():
	var portal_now = portal.instance()
	add_child(portal_now)
	point_portal.unit_offset = rand_range(0, 1)
	portal_now.position = point_portal.position
	if Global.closing_portal == Global.COUNT_PORTAL and spawn_core_portal == false:
		spawn_core_portal = true
		portal_now.make_current()
		portal_now.position = last_portal_point.position
		place_cyborg.monitorable = true
		place_cyborg.monitoring = true
	count_portal += 1


func _on_Cyborg_spawn_timer_timeout():
	var cyborg_new = cyborg.instance()
	add_child(cyborg_new)
	cyborg_new.position = pos_list[int(rand_range(0, 3))].position
	if cyborg_new.position.x > 0:
		cyborg_new.flip_anim()


func _on_Place_cyborg_body_entered(body):
	cyborg_spawn_timer.stop()
	body.stand_ready()
	$Stop_timer.start()


func _on_Stop_timer_timeout():
	cyborg_spawn_timer.start()
