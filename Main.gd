extends Node2D

signal free_coin


export (PackedScene) var Enemy
export (PackedScene) var Coin
var score = 0
var highscore = 0


func _ready():
	load_highscore()
	get_node("HUD/Restart").connect("pressed", self, "start")


func load_highscore():
	var file = File.new()
	file.open("highscore", File.READ)
	var content = file.get_as_text()
	highscore = int(content)
	file.close()


func coin_picked():  #free old coin and create new one
	emit_signal("free_coin")
	var new_coin = Coin.instance()
	add_child(new_coin)
	connect("free_coin", new_coin, "_on_Main_free_coin")
	score = score + 1
	get_node("HUD/Score").set_text("Score: " + str(score))


func game_over():
	$Player.hide()
	get_node("Player/CollisionShape2D").set_deferred("disabled", true)
	$EnemySpawnTimer.stop()
	$HUD.game_over_hud(score, highscore)
	if int(score) > int(highscore):
		highscore = score


func start():
	$EnemySpawnTimer.start(0.75)
	
	emit_signal("free_coin")  #free coin from last game
	var new_coin = Coin.instance()
	add_child(new_coin)
	connect("free_coin", new_coin, "_on_Main_free_coin")
	
	$HUD.hide_hud()
	score = 0
	get_node("HUD/Score").set_text("Score: 0")
	get_node("Player/CollisionShape2D").set_deferred("disabled", false)
	$Player.center_player()
	$Player.show()


func _on_EnemySpawnTimer_timeout():
	var new_enemy = Enemy.instance()
	add_child(new_enemy)

