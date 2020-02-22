extends Node

var highscore = 0


func _ready():
	load_highscore()

func get_highscore():
	return highscore

func load_highscore():
	var file = File.new()
	file.open("highscore", File.READ)
	highscore = file.get_as_text()
	file.close()
	
func save_highscore(new_highscore):
	var file = File.new()
	file.open("highscore", File.WRITE)
	file.store_string(str(new_highscore))
	file.close()
	
func update_highscore(score):
	if(int(score) > int(highscore)):
		save_highscore(score)
		highscore = score