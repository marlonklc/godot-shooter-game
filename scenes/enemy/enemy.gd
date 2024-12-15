class_name Enemy extends CharacterBody2D;

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('player')
@export var animation:AnimationPlayer

const SPEED: float = 180.0
const damage:int = 5

func _ready():
	animation.play('running')

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	
	var angle = direction.angle()
	rotation = lerp_angle(global_rotation, angle, .03)
	
	velocity = direction * SPEED
	move_and_slide()

func _on_area_damage_area_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Bullet or Granade:
		death()

func death():
	animation.play('death');
	await animation.animation_finished;
	queue_free();
