extends Control

onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")

onready var timer_total_prog = $Timer_total
var time_now = Global.TOTAL_TIME
onready var timer_check_1 = $Timer_check_1
var time_check_1_now = Global.CHECK_1_BEAR
onready var timer_check_2 = $Timer_check_2
var time_check_2_now = Global.CHECK_2_GENTS

onready var dead_timer = $Dead_timer
onready var check_1_bear = $Check_1_bear
onready var check_2_gents = $Check_2_gents
onready var total_timer = $Total_timer
onready var noise1 = $Sprite
onready var noise2 = $Sprite2
onready var noise3 = $Sprite3

var start1 = false
var start2 = false
var start3 = false
var check_fail = false

func _ready():
	check_1_bear.wait_time = Global.CHECK_1_BEAR
	timer_check_1.max_value = Global.CHECK_1_BEAR
	timer_check_1.value = time_check_1_now
	
	total_timer.wait_time = Global.TOTAL_TIME
	timer_total_prog.max_value = Global.TOTAL_TIME
	timer_total_prog.value = time_now
	
	check_2_gents.wait_time = Global.CHECK_2_GENTS
	timer_check_2.max_value = Global.CHECK_2_GENTS
	timer_check_2.value = time_check_2_now
	
	total_timer.start()
	check_1_bear.start()
	check_2_gents.start()
	noise1.modulate.a = 0
	noise2.modulate.a = 0
	noise3.modulate.a = 0
	

func _process(delta):
	time_now -= delta
	timer_total_prog.value = time_now
	time_check_1_now -= delta
	timer_check_1.value = time_check_1_now
	time_check_2_now -= delta
	timer_check_2.value = time_check_2_now
	if start1:
		noise1.modulate.a = lerp(noise1.modulate.a, 1, delta)
	if start2:
		noise2.modulate.a = lerp(noise2.modulate.a, 1, delta)
	if start3:
		noise3.modulate.a = lerp(noise3.modulate.a, 1, delta)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !has_node("Pause"):
			add_child(load("res://GUI/Pause.tscn").instance())

func active_noise(check):
	anim_dots.travel("noise")
	if dead_timer.is_stopped():
		dead_timer.start()
	if check == 3:
		start1 = true
		start2 = true
		start3 = true
	elif check == 2:
		start2 = true
		start3 = true
	else:
		start3 = true



func _on_Dead_timer_timeout():
	get_tree().change_scene("res://GUI/Game Over.tscn")

func _on_Check_1_bear_timeout():
	if Global.count_leave_bear < Global.COUNT_BEAR or Global.bear_is_leave:
		active_noise(3)


func _on_Total_timer_timeout():
	get_tree().change_scene("res://GUI/Game complete.tscn")


func _on_Check_2_gents_timeout():
	if Global.count_villager < 2 or !Global.starosta_selfback or Global.gentleman_leave:
		active_noise(2)


func _on_Scene3_meteor_has_down():
	active_noise(2)
