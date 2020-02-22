extends KinematicBody2D

var speed
var screen_size
var ready_to_go = false
var velocity = Vector2()


func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_screen_exited")
	disable_sprite()

func _on_screen_exited():
	queue_free()
	
func set_speed(new_speed):
	speed = new_speed

func init_indicator(x, y):
	$SpawnIndicatorTimer.start(2)
	show_indicator(x, y)
	
func show_indicator(x, y):
	$SpawnIndicator.position.x = x
	$SpawnIndicator.position.y = y
	$SpawnIndicator.show()
	
func hide_indicator():
	$SpawnIndicator.hide()
	$SpawnIndicator.queue_free()

func _on_SpawnIndicatorTimer_timeout():
	hide_indicator()
	$SpawnIndicatorTimer.stop()
	enable_sprite()
	ready_to_go = true
	
func enable_sprite():
	$Sprite.show()
	$CollisionShape2D.set_deferred("disabled", false)
	
func disable_sprite():
	$Sprite.hide()
	$CollisionShape2D.set_deferred("disabled", true)
