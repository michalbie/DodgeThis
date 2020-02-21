extends Node2D

signal prepare_new_game

export (PackedScene) var Enemy
export (PackedScene) var Coin


func _ready():
	get_node("Popup/StartButton").connect("pressed", self, "start")
	$Popup.show_main_menu_popup()

func start():
	$EnemySpawnTimer.start(0.75)
	$HUD.reset_score()
	$HUD.show_score()
	generate_new_coin()	
	$Popup.hide_popup()
	$Player.enable_player()

func on_coin_picked():  #create new one
	generate_new_coin()
	$HUD.update_score()

func game_over():
	$Player.disable_player()
	$EnemySpawnTimer.stop()
	$SaveSystem.update_highscore($HUD.get_score())
	$Popup.show_game_over_popup($SaveSystem.get_highscore())
	emit_signal("prepare_new_game")
	
func generate_new_coin():
	var new_coin = Coin.instance()
	call_deferred("add_child", new_coin)
	new_coin.connect("picked", self, "on_coin_picked")
	connect("prepare_new_game", new_coin, "free_coin")

func _on_EnemySpawnTimer_timeout():
	var new_enemy = Enemy.instance()
	call_deferred("add_child", new_enemy)

