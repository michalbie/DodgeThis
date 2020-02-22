extends Node2D

signal prepare_new_game

export (PackedScene) var Enemy1
export (PackedScene) var Special_Enemy1
export (PackedScene) var Special_Enemy2
export (PackedScene) var Special_Enemy3
export (PackedScene) var Coin 


func _ready():
	get_node("Popup/StartButton").connect("pressed", self, "start")
	$Popup.show_main_menu_popup()

func start():
	$EnemySpawn.start(0.8)
	$SpecialEnemySpawn.start(5)
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
	$EnemySpawn.stop()
	$SpecialEnemySpawn.stop()
	$SaveSystem.update_highscore($HUD.get_score())
	$Popup.show_game_over_popup($SaveSystem.get_highscore())
	emit_signal("prepare_new_game")
	
func generate_new_coin():
	var new_coin = Coin.instance()
	call_deferred("add_child", new_coin)
	new_coin.connect("picked", self, "on_coin_picked")
	connect("prepare_new_game", new_coin, "free_coin")

func _on_EnemySpawnTimer_timeout():
	var new_enemy = Enemy1.instance()
	call_deferred("add_child", new_enemy)

func _on_SpecialEnemyTimer_timeout():
	generate_special_enemy()

func generate_special_enemy():
	var random_special = randi()%3
	match random_special:
		0:
			var new_enemy = Special_Enemy1.instance()
			call_deferred("add_child", new_enemy)
		1:
			var new_enemy = Special_Enemy2.instance()
			call_deferred("add_child", new_enemy)
		2:
			var new_enemy = Special_Enemy3.instance()
			call_deferred("add_child", new_enemy)