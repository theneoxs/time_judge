extends Control


func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !has_node("Pause"):
			add_child(load("res://GUI/Pause.tscn").instance())
