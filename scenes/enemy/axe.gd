extends RigidBody2D

@export var enemyReference: CharacterBody2D : set = set_enemy 
@export var animation: AnimationPlayer

const SPEED: float = 125.0
const damage: int = 25
var direction: Vector2
var canMove: bool = true

func set_enemy(reference:CharacterBody2D):
	enemyReference = reference

func _ready():
	animation.play('throwing')
	
	var enemyMarker:Marker2D = enemyReference.get_node('Marker2D')
	var player:CharacterBody2D = get_tree().get_first_node_in_group('player')
	
	global_position = enemyMarker.get_global_position()

	direction = global_position.direction_to(player.global_position)
	
func _physics_process(delta):
	if canMove:
		global_position += direction * SPEED * delta

func _on_timer_timeout():
	#animation.play('hitted')
	#await animation.animation_finished
	queue_free()

func _on_damage_area_body_entered(_body):
	canMove = false
	animation.play('hitted')
	await animation.animation_finished
