extends Control


func _process(delta):
	if Global.bear_is_leave:
		$ColorRect/ColorRect/Checklist/VBoxContainer/List1.modulate = Color(0.87, 0, 0, 1)
	elif Global.bear_is_dead:
		$ColorRect/ColorRect/Checklist/VBoxContainer/List1.modulate = Color(0.06, 0.6, 0, 1)
	if Global.count_leave_bear >= 6:
		$ColorRect/ColorRect/Checklist/VBoxContainer/List2.modulate = Color(0.06, 0.6, 0, 1)
	else:
		$ColorRect/ColorRect/Checklist/VBoxContainer/List2.text = "Chase away 6 bears (" + str(Global.count_leave_bear) + ")"



func _on_Exit_pressed():
	get_tree().change_scene("res://GUI/Main_menu.tscn")


func _on_Return_pressed():
	queue_free()
