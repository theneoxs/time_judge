extends Control


func _input(event):
	if event.is_pressed():
		get_tree().change_scene("res://GUI/Main_menu.tscn")
