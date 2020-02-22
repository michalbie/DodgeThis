extends "res://Scripts/Enemy.gd"


func _ready():
	set_speed(350)
	set_moving_path()
	init_indicator($Sprite.position.x, $Sprite.position.y)
	
func _physics_process(delta):
	if ready_to_go:
		velocity = velocity.normalized() * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			var motion = collision.remainder.bounce(collision.normal)
			velocity = velocity.bounce(collision.normal)
			move_and_collide(motion)
		
func set_moving_path():
	var horizontal_dir = randi()%2
	var vertical_dir = randi()%2
	
	if horizontal_dir == 0:			#left
		velocity.x = -(randi()%2+1)
		position.x = randi()%int(screen_size.x) + int(screen_size.x/2)
	elif horizontal_dir == 1:		#right
		velocity.x = randi()%2+1
		position.x = randi()%int(screen_size.x/2)
		$Sprite.set_flip_h(true)
	if vertical_dir == 0:			#down
		velocity.y = randi()%2+1
		position.y = 0
	elif vertical_dir == 1:			#up
		velocity.y = -(randi()%2+1)
		position.y = screen_size.y

