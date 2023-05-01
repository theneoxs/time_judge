extends Control



func _on_Exit_btn_pressed():
	get_tree().quit()


func _on_Start_btn_pressed():
	get_tree().change_scene("res://Scene/Game.tscn")


func _on_Author_btn_pressed():
	get_tree().change_scene("res://GUI/Author.tscn")
