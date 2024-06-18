extends Marker2D

func _ready():
	#pass
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN);

func _process(_delta):
	position = get_global_mouse_position();
