extends Area2D

signal hit

export var speed = 400
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	disable_player()

func center_player():
	position.x = screen_size.x/2
	position.y = screen_size.y/2
	
func disable_player():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

func enable_player():
	center_player()
	show()
	$CollisionShape2D.set_deferred("disabled", false)

func _physics_process(delta):
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
	
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	disable_player()
	emit_signal("hit")
