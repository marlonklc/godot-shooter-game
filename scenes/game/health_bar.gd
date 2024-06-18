extends ProgressBar

func _ready():
	value = PlayerStats.get_current_health()
	PlayerStats.connect("update_health", update_health)
	
func update_health(current_health):
	value = current_health
