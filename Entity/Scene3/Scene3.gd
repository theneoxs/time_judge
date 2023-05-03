extends Node2D

signal meteor_has_down

var trash = load("res://Entity/Scene3/Trash.tscn")
var car_owner = load("res://Entity/Scene3/Car_owner.tscn")
var car_owner_now = null

onready var pos_list = [$TrashPos/Pos1, $TrashPos/Pos2, $TrashPos/Pos3, $TrashPos/Pos4]
onready var royal_man = $Header
onready var meteor_coord = $Meteor_coodr
onready var meteor_coord_miss = $Meteor_coodr_miss
onready var meteor = $Meteor
onready var dead_timer = $Dead_timer
onready var trash_spawn_timer = $Trash_spawn_timer
onready var meteor_timer = $Meteor_timer

var is_meteor_moving = false

func _ready():
	seed(Time.get_unix_time_from_system())
	trash_spawn_timer.wait_time = Global.TIME_CREATE_TRASH
	trash_spawn_timer.start()
	meteor_timer.wait_time = Global.DOWN_METEOR
	meteor_timer.start()

func _physics_process(delta):
	if royal_man != null:
		if royal_man.position.x <= -400 or royal_man.position.x >= 400:
			royal_man.queue_free()
			royal_man = null
	if is_meteor_moving:
		if !Global.item_is_picked:
			meteor.position = lerp(meteor.position, meteor_coord.position, 0.5*delta)
			meteor.scale = lerp(meteor.scale, Vector2(7, 7), delta)
		else:
			meteor.position = lerp(meteor.position, meteor_coord_miss.position, 0.5*delta)
			meteor.scale = lerp(meteor.scale, Vector2(4, 4), delta)

func _on_Trash_spawn_timer_timeout():
	var new_trash = trash.instance()
	add_child(new_trash)
	new_trash.position = pos_list[int(rand_range(0, 3))].position
	Global.count_trash += 1


func _on_Car_car_crash():
	if car_owner_now == null:
		car_owner_now = car_owner.instance()
		add_child(car_owner_now)
		car_owner_now.position = Vector2(-400, 150)


func _on_Meteor_timer_timeout():
	is_meteor_moving = true
	if !Global.item_is_picked:
		dead_timer.start()


func _on_Dead_timer_timeout():
	emit_signal("meteor_has_down")
