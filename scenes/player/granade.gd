class_name Granade extends Area2D

var velocity = Vector2(0, 0)
var speed = 120.0
var target_position
const SAFE_TARGET_POSITION_DISTANCE:float = 10.0

@onready var animation:AnimationPlayer = get_node("AnimationPlayer")
@onready var rollingAudio:AudioStreamPlayer = get_node("RollingAudio")

func _ready():
	animation.play('rolling')
	rollingAudio.play()
	
	var playerNode = get_tree().get_first_node_in_group('player')
	var markerShoot:Marker2D = playerNode.get_children()[2] # shame on me
	
	global_position = markerShoot.get_global_position()
	rotation = position.angle_to_point(get_global_mouse_position())
	
	target_position = get_global_mouse_position()
	
	velocity = get_global_mouse_position() - position
	
func _process(_delta):
	if global_position.distance_to(target_position) < SAFE_TARGET_POSITION_DISTANCE:
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
	
