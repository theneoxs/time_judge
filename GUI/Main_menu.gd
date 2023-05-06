extends Control

onready var title_back = $ColorRect
var is_start = false

onready var sound_btn = $Background/Sound
onready var music_btn = $Background/Music

func _ready():
	if !Global.get_node("Main_menu_sound").playing:
		Global.play_main_menu_sound()
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
	Global.play_click()
	get_tree().quit()


func _on_Start_btn_pressed():
	Global.play_click()
	Global.silence_main_menu_sound()
	$Timer.start()
	is_start = true


func _on_Author_btn_pressed():
	Global.play_click()
	get_tree().change_scene("res://GUI/Author.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://Scene/Game.tscn")


func _on_Btn_mouse_entered():
	Global.play_focus()

func set_icon_status():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Effects")):
		sound_btn.modulate.a = 0.3
	else:
		sound_btn.modulate.a = 1
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		music_btn.modulate.a = 0.3
	else:
		music_btn.modulate.a = 1

func _on_Sound_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), !AudioServer.is_bus_mute(AudioServer.get_bus_index("Effects")))
	set_icon_status()


func _on_Music_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !AudioServer.is_bus_mute(AudioServer.get_bus_index("Music"))) # Replace with function body.
	set_icon_status()
