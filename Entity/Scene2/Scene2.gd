extends Node2D

onready var man1 = $Man1
onready var man2 = $Man2
onready var man3 = $Man3
onready var man4 = $Starosta
var gentleman = load("res://Entity/Scene2/Gentleman.tscn")
var gentleman_now = null
onready var gentle_pos = $Gentle_pos
onready var down_starosta = $Down_starosta
onready var gentleman_incoming = $Gentleman_incoming

func _ready():
	gentleman_incoming.wait_time = Global.GENTLEMAN_INCOMING
	gentleman_incoming.start()

func _physics_process(delta):
	if man1 != null:
		if man1.position.x >= 405 or man1.position.x <= -405 or man1.position.y >= 220 or man1.position.y <= -220:
			man1.queue_free()
			man1 = null
			Global.count_villager -= 1
	if man2 != null:
		if man2.position.x >= 405 or man2.position.x <= -405 or man2.position.y >= 220 or man2.position.y <= -220:
			man2.queue_free()
			man2 = null
			Global.count_villager -= 1
	if man3 != null:
		if man3.position.x >= 405 or man3.position.x <= -405 or man3.position.y >= 220 or man3.position.y <= -220:
			man3.queue_free()
			man3 = null
			Global.count_villager -= 1
	if man4 != null:
		if man4.position.x >= 405 or man4.position.x <= -405 or man4.position.y >= 220 or man4.position.y <= -220:
			man4.queue_free()
			man4 = null
			Global.count_villager -= 1
	if gentleman_now != null:
		if gentleman_now.position.x >= 405 or gentleman_now.position.x <= -405:
			gentleman_now.queue_free()
			gentleman_now = null
	 


func _on_Gentleman_incoming_timeout():
	gentleman_now = gentleman.instance()
	add_child(gentleman_now)
	gentleman_now.position = gentle_pos.position
	gentleman_now.scale = Vector2(2, 2)
	down_starosta.start()


func _on_Down_starosta_timeout():
	man4.down_to_gentle()
