extends Control

onready var fin_screen = $FinScreen

onready var sprites = $AnimationTree
onready var anim_dots = sprites.get("parameters/playback")

onready var timer_total_prog = $Timer_total
var time_now = Global.TOTAL_TIME
onready var timer_check_1 = $Timer_check_1
var time_check_1_now = Global.CHECK_1_BEAR
onready var timer_check_2 = $Timer_check_2
var time_check_2_now = Global.CHECK_2_GENTS
onready var timer_check_3 = $Timer_check_3
var time_check_3_now = Global.DOWN_METEOR+2

onready var dead_timer = $Dead_timer
onready var check_1_bear = $Check_1_bear
onready var check_2_gents = $Check_2_gents
onready var check_3_city = $Check_3_city
onready var total_timer = $Total_timer
onready var noise1 = $Sprite
onready var noise2 = $Sprite2
onready var noise3 = $Sprite3

onready var fin_timer = $Fin_timer
onready var timer_label = $Timer_label

var start1 = false
var start2 = false
var start3 = false
var check_fail = false

var start_fin = false

var is_started = false

func _ready():
	Global.start_game_sound()
	Global.stop_main_menu_sound()
	fin_screen.color = Color("8f6854")
	fin_screen.modulate.a = 1
	
	check_1_bear.wait_time = Global.CHECK_1_BEAR
	timer_check_1.max_value = Global.CHECK_1_BEAR
	timer_check_1.value = time_check_1_now
	
	total_timer.wait_time = Global.TOTAL_TIME
	timer_total_prog.max_value = Global.TOTAL_TIME
	timer_total_prog.value = time_now
	timer_label.text = ("%d:%02d" % [time_now/60, time_now%60])
	
	check_2_gents.wait_time = Global.CHECK_2_GENTS
	timer_check_2.max_value = Global.CHECK_2_GENTS
	timer_check_2.value = time_check_2_now
	
	check_3_city.wait_time = Global.DOWN_METEOR+2
	timer_check_3.max_value = Global.DOWN_METEOR+2
	timer_check_3.value = time_check_3_now
	
	total_timer.start()
	check_1_bear.start()
	check_2_gents.start()
	check_3_city.start()
	noise1.modulate.a = 0
	noise2.modulate.a = 0
	noise3.modulate.a = 0
	

func _process(delta):
	if !is_started:
		fin_screen.modulate.a = lerp(fin_screen.modulate.a, -0.5, delta)
		if fin_screen.modulate.a <= 0.05:
			fin_screen.modulate.a = 0
			is_started = true
	
	time_now -= delta
	timer_total_prog.value = time_now
	time_check_1_now -= delta
	timer_check_1.value = time_check_1_now
	time_check_2_now -= delta
	timer_check_2.value = time_check_2_now
	time_check_3_now -= delta
	timer_check_3.value = time_check_3_now
	timer_label.text = ("%d:%02d" % [int(time_now)/60, int(time_now)%60])
	if start1:
		noise1.modulate.a = lerp(noise1.modulate.a, 1, delta)
	if start2:
		noise2.modulate.a = lerp(noise2.modulate.a, 1, delta)
	if start3:
		noise3.modulate.a = lerp(noise3.modulate.a, 1, delta)
	if start_fin:
		fin_screen.modulate.a = lerp(fin_screen.modulate.a, 1, delta)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !has_node("Pause"):
			$In_pause.play()
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
	Global.silence_game_sound()
	start_fin = true
	fin_screen.color = Color(0, 0, 0)
	check_fail = true
	fin_timer.start()

func _on_Check_1_bear_timeout():
	if Global.count_leave_bear < Global.COUNT_BEAR or Global.bear_is_leave:
		active_noise(3)


func _on_Total_timer_timeout():
	start_fin = true
	fin_screen.color = Color(1, 1, 1)
	fin_timer.start()


func _on_Check_2_gents_timeout():
	if Global.count_villager < 2 or !Global.starosta_selfback or Global.gentleman_leave:
		active_noise(2)


func _on_Scene3_meteor_has_down():
	active_noise(2)


func _on_Fin_timer_timeout():
	if check_fail:
		get_tree().change_scene("res://GUI/Game Over.tscn")
	else:
		get_tree().change_scene("res://GUI/Game complete.tscn")


func _on_Check_3_city_timeout():
	if !Global.item_is_picked:
		active_noise(2)


func _on_Game_tree_exiting():
	Global.stop_Game_sound()


func _on_Return_mouse_entered():
	Global.play_focus()


func _on_Return_pressed():
	Global.play_click()
	if !has_node("Pause"):
		$In_pause.play()
		add_child(load("res://GUI/Pause.tscn").instance())
