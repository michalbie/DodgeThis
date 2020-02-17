extends Area2D

signal hit
signal picked

export var speed = 400
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()
	set_deferred("disabled", true)
	center_player()


func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func center_player():
	position.x = screen_size.x/2
	position.y = screen_size.y/2


func _on_Player_body_entered(body):
	if "Coin" in body.get_name():	#Check what object collided with player
		emit_signal("picked")
	else:
		emit_signal("hit")
