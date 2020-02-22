extends "res://Scripts/Enemy.gd"

var gravity = 400
var jump_power = 400
var speed_x = 400
var speed_y = 0


func _ready():
	set_moving_path()
	init_indicator($Sprite.position.x, $Sprite.position.y)
	$JumpTimer.start(1)
	$Animation.play("moving")

func _physics_process(delta):
	if ready_to_go:
		speed_y += gravity * delta
		velocity.x = speed_x * delta
		velocity.y = speed_y * delta
		position += velocity

func set_moving_path():
	var direction = randi()%2
	position.y = randi()%(int(screen_size.y-50))+50   #be sure it will always be visible

	if direction == 0:	#right
		position.x = 0
		$Sprite.set_flip_h(true)
	else:
		position.x = screen_size.x
		speed_x = -speed_x

func jump():
	if ready_to_go:
		speed_y = -jump_power

func _on_JumpTimer_timeout():
	jump()
