extends RigidBody2D


export var speed = 350
var screen_size
var velocity
var horizontal_dir
var vertical_dir


func _ready():
	screen_size = get_viewport_rect().size
	random_enemy()
	get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_screen_exited")


func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta


func _on_screen_exited():
	queue_free()


func random_enemy():
	velocity = Vector2()
	randomize()
	horizontal_dir = randi()%2
	vertical_dir = randi()%2
	
	if horizontal_dir == 0:			#left
		velocity.x = -(randi()%2+1)
		position.x = randi()%int(screen_size.x) + int(screen_size.x/2)
		$AnimatedSprite.animation = "left"
	elif horizontal_dir == 1:		#right
		velocity.x = randi()%2+1
		position.x = randi()%int(screen_size.x/2)
		$AnimatedSprite.animation = "right"
	if vertical_dir == 0:			#down
		velocity.y = randi()%2+1
		position.y = 0
	elif vertical_dir == 1:			#up
		velocity.y = -(randi()%2+1)
		position.y = screen_size.y
