extends "res://Scripts/Enemy.gd"

func _ready():
	set_speed(500)
	set_moving_path()
	init_indicator($Sprite.position.x, $Sprite.position.y)

func _physics_process(delta):
	if ready_to_go:
		velocity = velocity.normalized() * speed
		position += velocity * delta

func set_moving_path():
	var direction = randi()%2
	position.y = randi()%(int(screen_size.y-50))+50	#be sure it will always be visible
	velocity.y = 0
	
	if direction == 0:	#right
		position.x = 0
		velocity.x = 1
	else:
		position.x = screen_size.x
		velocity.x = -1
		$Sprite.set_flip_h(true)