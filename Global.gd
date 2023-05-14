extends Node

var is_start_game = false

var TOTAL_TIME = 300
var WAIT_WOODCUTTER = 140
var CHECK_1_BEAR = 200
var CHECK_2_GENTS = 250
var DOWN_STAROSTA = 120
var GENTLEMAN_INCOMING = 180
var COUNT_BEAR = 6
var DOWN_METEOR = 270
var DOWN_PIANO = 180
var TIME_CREATE_TRASH = 6
var COUNT_PORTAL = 12
var TIME_CREATE_PORTAL = 6
var TIME_CREATE_CYBORG = 8
var WAIT_PORTAL_3 = 10
var MAX_TRASH = 9
var RUSH_MAN_MIN_TIMER = 4
var RUSH_MAN_MAX_TIMER = 10

var bear_is_dead = false
var count_leave_bear = 0
var bear_is_leave = false

var count_villager = 4
var starosta_selfback = false
var gentleman_leave = false

var count_trash = 0
var car_crashed = false
var item_is_picked = false

var closing_portal = 0
var cyborg_repait = 0
var item_sending = false

var is_first_woodman = false
var is_throw_item = false

var is_silent_main_menu_sound = false
var is_silent_game_sound = false

var is_start_game_sound = false
var is_main_menu_stopped = false

onready var main_menu_sound = $Main_menu_sound
onready var game_sound = $Game_sound
var is_game_stopped = false

func clear_res():
	bear_is_dead = false
	count_leave_bear = 0
	bear_is_leave = false
	count_villager = 4
	starosta_selfback = false
	gentleman_leave = false
	count_trash = 0
	car_crashed = false
	item_is_picked = false
	closing_portal = 0
	cyborg_repait = 0
	item_sending = false
	is_first_woodman = false
	is_throw_item = false

func _process(delta):
	if is_silent_main_menu_sound:
		main_menu_sound.volume_db = lerp(main_menu_sound.volume_db, -80, 0.5*delta)
		if main_menu_sound.volume_db <= -40:
			stop_main_menu_sound()
			main_menu_sound.volume_db = 0
			is_silent_main_menu_sound = false
	if is_silent_game_sound:
		game_sound.volume_db = lerp(game_sound.volume_db, -80, 0.5*delta)
		if game_sound.volume_db <= -30:
			stop_Game_sound()
			game_sound.volume_db = 0
			is_silent_game_sound = false
	if is_start_game_sound:
		game_sound.volume_db = lerp(game_sound.volume_db, 1, 2*delta)
		if game_sound.volume_db >= -1:
			game_sound.volume_db = 0
			is_start_game_sound = false

func play_focus():
	$Focus.play()

func play_click():
	$Click.play()

func play_from_pause():
	$From_pause.play()

func play_main_menu_sound():
	is_main_menu_stopped = false
	main_menu_sound.play()

func stop_main_menu_sound():
	is_main_menu_stopped = true
	main_menu_sound.stop()

func play_Game_sound():
	is_game_stopped = false
	game_sound.play()

func stop_Game_sound():
	is_game_stopped = true
	game_sound.stop()

func _on_Game_sound_finished():
	if !is_game_stopped:
		game_sound.play()

func silence_main_menu_sound():
	is_silent_main_menu_sound = true

func silence_game_sound():
	is_silent_game_sound = true

func start_game_sound():
	game_sound.volume_db = -80
	play_Game_sound()
	is_start_game_sound = true

func play_trash():
	$Trash.play()


func _on_Main_menu_sound_finished():
	if !is_main_menu_stopped:
		main_menu_sound.play()
