extends Node

var TOTAL_TIME = 600
var WAIT_WOODCUTTER = 10
var CHECK_1_BEAR = 300
var CHECK_2_GENTS = 420
var DOWN_STAROSTA = 250
var GENTLEMAN_INCOMING = 350
var COUNT_BEAR = 6
var DOWN_METEOR = 550
var DOWN_PIANO = 330
var TIME_CREATE_TRASH = 5
var COUNT_PORTAL = 10
var TIME_CREATE_PORTAL = 3
var TIME_CREATE_CYBORG = 10
var WAIT_PORTAL_3 = 10

var bear_is_dead = false
var count_leave_bear = 0
var bear_is_leave = false

var count_villager = 4
var starosta_selfback = false
var gentleman_leave = false

var count_trash = 0
var car_crashed = false #Использовать к порталу, пока не используемое
var item_is_picked = false

var closing_portal = 0
var cyborg_repait = 0
var item_sending = false

var is_first_woodman = false
