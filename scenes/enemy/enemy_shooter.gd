class_name EnemyShooter extends CharacterBody2D 

@onready var playerNode:CharacterBody2D = get_tree().get_first_node_in_group('player')
@export var timer:Timer
@export var animation:AnimationPlayer

const SPEED: float = 80.0
const damage: int = 39
const DISTANCE_ATTACK: float = 220.0

const axePath = preload("res://scenes/enemy/axe.tscn")

func _physics_process(_delta):
	var direction = global_position.direction_to(playerNode.global_position)
	
	var angle = direction.angle()
	rotation = lerp_angle(global_rotation, angle, .03)
	
	if global_position.distance_to(playerNode.global_position) > DISTANCE_ATTACK:
		velocity = direction * SPEED
		move_and_slide()
		
		timer.stop()
	else:
		if timer.time_left <= 0:
			timer.start()
	
	#look_at(get_global_mouse_position())

func _on_timer_timeout():
	var axeSpawn = axePath.instantiate()
	axeSpawn.set_enemy(self)
	
	get_parent().add_child(axeSpawn)

func _on_area_damage_area_entered(_area_rid, area, _area_shape_index, _deathAudiolocal_shape_index):
	if area is Bullet or Granade:
		kill()

func kill():
	timer.stop()
	animation.play('kill')
	await animation.animation_finished
	queue_free()
