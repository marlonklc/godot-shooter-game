extends CanvasLayer

@onready var animation:AnimationPlayer = get_node("Animation")

func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_button_continue_pressed()


func _on_button_continue_pressed():
	var isVisible = !visible
	get_tree().paused = isVisible
	
	if isVisible:
		visible = isVisible
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		animation.play('pause')
		
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
		animation.play('resume')
		await animation.animation_finished
		visible = isVisible
		
