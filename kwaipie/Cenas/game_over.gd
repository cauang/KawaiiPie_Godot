extends CanvasLayer

@onready var spawn_point_1 = $spawnPointPlayer1
@onready var spawn_point_2 = $spawnPointPlayer2
@onready var winner_label = $WinnerLabel

func _ready():
	if Global.chosen_players.size() < 2:
		push_error("Erro: Selecione 2 jogadores")
		return
	
	spawn_players()
	display_winner()

func spawn_players():
	# Player 1
	var player1_scene = load(Global.chosen_players[0])
	var player1 = player1_scene.instantiate()
	player1.position = spawn_point_1.position
	add_child(player1)
	
	# Player 2
	var player2_scene = load(Global.chosen_players[1])
	var player2 = player2_scene.instantiate()
	player2.position = spawn_point_2.position
	add_child(player2)
	
	# Configura animações
	if player1.has_method("set_game_over_state"):
		player1.set_game_over_state(Global.last_winner == 1)
	
	if player2.has_method("set_game_over_state"):
		player2.set_game_over_state(Global.last_winner == 2)

func display_winner():
	match Global.last_winner:
		1: winner_label.text = "Player 1 Venceu!!!"
		2: winner_label.text = "Player 2 Venceu!!!"
		_: winner_label.text = "Tempo Esgotado!"

func _on_cancelar_pressed():
	get_tree().quit()

func _on_recomeçar_pressed():
	get_tree().change_scene_to_file("res://Cenas/start.tscn")
