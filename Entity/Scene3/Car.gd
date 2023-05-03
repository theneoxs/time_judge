extends StaticBody2D

signal car_crash

onready var alarm_timer = $Alarm_timer
onready var light = $Light2D

func alarm():
	emit_signal("car_crash")
	alarm_timer.start()


func _on_Alarm_timer_timeout():
	if light.color.r == 1:
		light.color.r = 0
	else:
		light.color.r = 1
