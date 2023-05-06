extends Control

onready var title_back = $ColorRect
var is_start = false

func _process(delta):
	if is_start:
		if title_back.modulate.a <= 1:
			title_back.modulate.a = lerp(title_back.modulate.a, 2, delta)
		else:
			title_back.modulate.a = 1
	else:
		if title_back.modulate.a <= 0.1:
			title_back.modulate.a = 0
		else:
			title_back.modulate.a = lerp(title_back.modulate.a, -0.5, delta)

func _on_Play_btn_pressed():
	Global.play_click()
	Global.silence_main_menu_sound()
	$Wait_timer.start()
	is_start = true


func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))


func _on_Wait_timer_timeout():
	get_tree().change_scene("res://Scene/Game.tscn")
