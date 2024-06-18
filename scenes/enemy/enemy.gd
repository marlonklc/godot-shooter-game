class_name Enemy extends CharacterBody2D;

const SPEED = 300.0;

var damage: int = 15

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('player');
@export var animation:AnimationPlayer;

func _physics_process(_delta):

	#look_at(player.get_global_position());
	
	##velocity = SPEED * _delta;
	
	move_and_slide();

func _on_area_damage_area_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Bullet or Granade:
		print('pela area')
		print((area as Area2D).get_parent().name)
		kill()

func kill():
	print('morri')
	animation.play("kill");
	await animation.animation_finished;
	queue_free();
