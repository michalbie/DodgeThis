extends "res://Scripts/Enemy.gd"

func _ready():
	set_speed(200)
	set_moving_path()
	init_indicator($Sprite.position.x, $Sprite.position.y)

func _physics_process(delta):
	if ready_to_go:
		velocity = velocity.normalized() * speed
		position += velocity * delta

func set_moving_path():
	position.x = randi()%int(screen_size.x)   #be sure it will always be visible
	position.y = -50
	velocity.y = 1