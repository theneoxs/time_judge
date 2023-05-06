extends Control



func _on_Back_btn_pressed():
	get_tree().change_scene("res://GUI/Main_menu.tscn")
	Global.play_click()


func _on_Back_btn_mouse_entered():
	Global.play_focus()


func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))

