extends Node2D

const enemyPath = preload("res://scenes/enemy/enemy.tscn")
const enemyAxePath = preload("res://scenes/enemy/enemy_shooter.tscn")

func _on_timer_timeout():
	var enemySpawn;
	
	if Time.get_time_dict_from_system().second % 2 == 0:
		enemySpawn = enemyAxePath.instantiate()
	else:
		enemySpawn = enemyPath.instantiate()
	
	enemySpawn.global_position = Vector2(randi() % 1001, randi() % 501)
	
	get_node(".").add_child(enemySpawn)
