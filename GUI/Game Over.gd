extends Control

onready var white_screen = $BlackScreen

func _process(delta):
	if white_screen.modulate.a >= 0.1:
		white_screen.modulate.a = lerp(white_screen.modulate.a, 0, 0.3*delta)
	else:
		white_screen.modulate.a = 0

func _input(event):
	if event.is_pressed():
		get_tree().change_scene("res://GUI/Main_menu.tscn")
