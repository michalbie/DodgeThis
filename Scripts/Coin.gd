extends Area2D

signal picked


func _ready():
	var screen_size = get_viewport_rect().size
	position.x = randi() % int(screen_size.x)
	position.y = randi() % int(screen_size.y)

func free_coin():
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	queue_free()

func _on_Coin_body_entered(body):
	if "Player" in body.get_name():
		free_coin()
		emit_signal("picked")

