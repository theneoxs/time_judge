extends Control

onready var title_back = $ColorRect
var is_start = false

func _ready():
	if Global.is_start_game:
		title_back.modulate.a = 0
	Global.is_start_game = true

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

func _on_Exit_btn_pressed():
	get_tree().quit()


func _on_Start_btn_pressed():
	$Timer.start()
	is_start = true


func _on_Author_btn_pressed():
	get_tree().change_scene("res://GUI/Author.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://Scene/Game.tscn")
