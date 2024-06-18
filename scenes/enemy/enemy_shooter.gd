class_name EnemyShooter extends CharacterBody2D

var speed: float = 500.0
var damage: int = 39

var axePath = preload("res://scenes/enemy/axe.tscn")
@onready var playerNode:CharacterBody2D = get_tree().get_first_node_in_group('player')	
@export var animation:AnimationPlayer

func _process(_delta):
	look_at(playerNode.get_global_position())
	
	#move_and_collide(velocity.normalized() * delta * speed)

func _on_timer_timeout():
	pass
	#print('shooot')
	#var axeSpawn = axePath.instantiate()
	
	#get_node('.').get_parent().add_child(axeSpawn)

func _on_area_damage_area_entered(_area_rid, area, _area_shape_index, _deathAudiolocal_shape_index):
	if area is Bullet or Granade:
		kill()

func kill():
	animation.play('kill')
	await animation.animation_finished
	queue_free()
