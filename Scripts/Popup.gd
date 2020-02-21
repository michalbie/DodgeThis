extends CanvasLayer


func _ready():
	$DescriptionLabel.hide()

func show_main_menu_popup():
	change_text("DodgeThis", "")
	show_popup()

func show_game_over_popup(highscore):
	change_text("Game Over", "Highscore: " + str(highscore))
	show_popup()

func change_text(topicText, descText):
	$TopicLabel.set_text(topicText)
	$DescriptionLabel.set_text(descText)
	
func hide_popup():
	$TopicLabel.hide()
	$DescriptionLabel.hide()
	$StartButton.hide()
	
func show_popup():
	$TopicLabel.show()
	$DescriptionLabel.show()
	$StartButton.show()
