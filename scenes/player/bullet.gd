class_name Bullet extends Area2D

var velocity = Vector2(0, 0)
var speed = 900.0
@export var animation:AnimationPlayer

func _ready():	
	var playerNode = get_tree().get_first_node_in_group('player')
	var markerShoot:Marker2D = playerNode.get_children()[2] # shame on me
	
	self.rotation = playerNode.rotation
	self.position = markerShoot.get_global_position()
	
	velocity = get_global_mouse_position() - self.position

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)

	global_position += direction * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is EnemyShooter or Enemy:
		queue_free()
