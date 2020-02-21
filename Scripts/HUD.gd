extends CanvasLayer

var score = 0


func _ready():
	$ScoreLabel.hide()
	
func get_score():
	return score	
	
func show_score():
	$ScoreLabel.show()
	
func update_score():
	score += 1
	$ScoreLabel.set_text("Score: " + str(score))
	
func reset_score():
	score = 0
	$ScoreLabel.set_text("Score: 0")
