extends CharacterBody2D

const SPEED = 200.0

const bulletPath = preload("res://scenes/player/bullet.tscn")
const granadePath = preload("res://scenes/player/granade.tscn")

@onready var animation:AnimationPlayer = get_node('AnimationPlayer')
@onready var shootAudio:AudioStreamPlayer = get_node('ShootAudio')
@onready var enemyBase: EnemyBase

var canAction:bool = true

func _ready():
	enemyBase = EnemyGreen.new()
	enemyBase.execute()
	PlayerStats.connect("died", death)
	
func death():
	canAction = false
	set_physics_process(false)
	animation.play('death')
	await animation.animation_finished
	get_tree().reload_current_scene()
	PlayerStats.reset()

func _physics_process(_delta):
	handle_movement()
	handle_rotation()
	
func handle_movement(): 
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	
func handle_rotation():
	var direction = get_global_mouse_position() - global_position
	var angle = direction.angle()
	global_rotation = lerp_angle(global_rotation, angle, .09)

func _input(event):
	if not canAction: return
		
	if event.is_action_pressed("click"):
		shoot()
	
	if event.is_action_pressed("right_click"):
		special_shoot()

func shoot():
	var bullet = bulletPath.instantiate()
	shootAudio.play()
	get_parent().add_child(bullet)
	animation.play('shoot')

func special_shoot():
	var granade = granadePath.instantiate()
	get_parent().add_child(granade)

func _on_damage_area_body_entered(body):
	if body is Enemy or EnemyShooter:
		animation.play('hit')
		PlayerStats.take_damage(body.damage)
