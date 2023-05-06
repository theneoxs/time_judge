extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


func _on_Play_btn_pressed():
	get_tree().change_scene("res://Scene/Game.tscn")
	


func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))
