extends KinematicBody2D

export var speed = 350
var screen_size
var velocity


func _ready():
	screen_size = get_viewport_rect().size
	random_direction()
	get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_screen_exited")
	$AnimatedSprite.animation = "pink" #I will create new types of ghosts


func _physics_process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	position += velocity * delta

func _on_screen_exited():
	queue_free()

func random_direction():
	velocity = Vector2()
	randomize()
	var horizontal_dir = randi()%2
	var vertical_dir = randi()%2
	
	if horizontal_dir == 0:			#left
		velocity.x = -(randi()%2+1)
		position.x = randi()%int(screen_size.x) + int(screen_size.x/2)
	elif horizontal_dir == 1:		#right
		velocity.x = randi()%2+1
		position.x = randi()%int(screen_size.x/2)
		$AnimatedSprite.set_flip_h(true)
	if vertical_dir == 0:			#down
		velocity.y = randi()%2+1
		position.y = 0
	elif vertical_dir == 1:			#up
		velocity.y = -(randi()%2+1)
		position.y = screen_size.y
