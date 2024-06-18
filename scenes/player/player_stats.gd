extends Node

signal update_health
signal died

var current_health = 100
var max_health = 100

func take_damage(value):
	current_health -= value
	
	emit_signal("update_health", current_health)
	
	if current_health <= 0:
		emit_signal("died")

func get_current_health():
	return current_health

func reset():
	current_health = max_health
