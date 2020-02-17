extends KinematicBody2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position.x = randi() % int(screen_size.x)
	position.y = randi() % int(screen_size.y)


func _on_Main_free_coin():
	hide()
	queue_free()
