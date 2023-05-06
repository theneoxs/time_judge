extends Control

onready var sound_btn = $ColorRect/ColorRect2/ColorRect/Sound
onready var music_btn = $ColorRect/ColorRect2/ColorRect/Music

func _ready():
	set_icon_status()

func set_icon_status():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Effects")):
		sound_btn.modulate.a = 0.3
	else:
		sound_btn.modulate.a = 1
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		music_btn.modulate.a = 0.3
	else:
		music_btn.modulate.a = 1

func _process(delta):
	if Global.bear_is_leave:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List1.modulate = Color(0.87, 0, 0, 1)
	elif Global.bear_is_dead:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List1.modulate = Color(0.06, 0.6, 0, 1)
	if Global.count_leave_bear >= Global.COUNT_BEAR:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List2.modulate = Color(0.06, 0.6, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List2.text = "Chase away "+str(Global.COUNT_BEAR)+" bears (" + str(Global.count_leave_bear) + ")"
	if Global.count_villager >= 2:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List3.text = "Return min 2 villager (" + str(Global.count_villager) + ")"
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List3.modulate = Color(0.06, 0.6, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List3.modulate = Color(0.87, 0, 0, 1)
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List3.text = "Return min 2 villager"
	if !Global.starosta_selfback:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List4.modulate = Color(0.87, 0, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List4.modulate = Color(0.06, 0.6, 0, 1)
	if Global.gentleman_leave:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List5.modulate = Color(0.87, 0, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist/VBoxContainer/List5.modulate = Color(0.06, 0.6, 0, 1)
	if Global.count_trash >= 12:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List1.modulate = Color(0.87, 0, 0, 1)
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List1.text = "Count less than 12 trash (" + str(Global.count_trash) + ")"
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List1.modulate = Color(0.06, 0.6, 0, 1)
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List1.text = "Count less than 12 trash (" + str(Global.count_trash) + ")"
	if Global.car_crashed:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List2.modulate = Color(0.06, 0.6, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List2.modulate = Color(0.87, 0, 0, 1)
	if Global.item_is_picked:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List3.modulate = Color(0.06, 0.6, 0, 1)
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List3.modulate = Color(0.87, 0, 0, 1)
	if Global.closing_portal >= 10:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List4.modulate = Color(0.06, 0.6, 0, 1)
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List4.text = "Close "+str(Global.closing_portal)+" portal (" + str(Global.closing_portal) + ")"
	else:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List4.text = "Close "+str(Global.closing_portal)+" portal (" + str(Global.closing_portal) + ")"
	if Global.item_sending:
		$ColorRect/ColorRect2/ColorRect/Checklist2/VBoxContainer/List5.modulate = Color(0.06, 0.6, 0, 1)
	


func _on_Exit_pressed():
	Global.play_click()
	get_tree().change_scene("res://GUI/Main_menu.tscn")


func _on_Return_pressed():
	Global.play_from_pause()
	queue_free()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_Return_pressed()

func _on_Btn_mouse_entered():
	Global.play_focus()


func _on_Sound_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), !AudioServer.is_bus_mute(AudioServer.get_bus_index("Effects")))
	set_icon_status()

func _on_Music_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !AudioServer.is_bus_mute(AudioServer.get_bus_index("Music"))) # Replace with function body.
	set_icon_status()
