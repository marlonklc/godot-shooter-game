class_name Granade extends Area2D

var velocity = Vector2(0, 0)
var speed = 120.0
var target_position

@onready var animation:AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	animation.play('rolling')
	
	var playerNode = get_tree().get_first_node_in_group('player')
	var markerShoot:Marker2D = playerNode.get_children()[2] # shame on me
	
	rotation = playerNode.rotation
	position = markerShoot.get_global_position()
	
	target_position = get_global_mouse_position()
	
	velocity = get_global_mouse_position() - self.position
	
func _process(_delta):
	if global_position.distance_to(target_position) < 10.0:
		play_explosion()
		
func play_explosion():
	animation.play('explosion')
	await animation.animation_finished
	queue_free()
	return
	
func _physics_process(delta):
	if global_position.distance_to(target_position) > 10.0:
		var direction = Vector2.RIGHT.rotated(rotation)

		global_position += direction * speed * delta

func _on_body_entered(body: CharacterBody2D):
	body.kill()

func _on_timer_timeout():
	play_explosion()
	
