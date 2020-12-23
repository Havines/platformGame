extends Node

signal coin_taked(coin_count)

var health_player
var coin_count = 0


func _coin_handler():
	coin_count += 1
	emit_signal("coin_taked", coin_count)
