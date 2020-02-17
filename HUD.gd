extends CanvasLayer


func _ready():
	$Highscore.hide()

func game_over_hud(score, highscore):
	$StartEndLabel.set_text("Game Over")
	if int(score) > int(highscore):		#save new highscore
		var file = File.new()
		file.open("highscore", File.WRITE)
		file.store_string(str(score))
		file.close()
		$Highscore.set_text("Highscore: " + str(score))
		
	else:
		$Highscore.set_text("Highscore: " + str(highscore))
	
	$Highscore.show()
	$StartEndLabel.show()
	$Restart.show()



func hide_hud():
	$Highscore.hide()
	$StartEndLabel.hide()
	$Restart.hide()
