extends Node

## Configurações do jogo
var pie_movement = 15
var pie_start_x = 0
var pie_limit = 375
var danger_threshold = 0.7

## Estado do jogo
var game_over = false
var cooldown_time = 0.02
var cooldown_timer = 0.0

## Referências aos nós
@onready var pie = $Pie
@onready var spawn_point_1 = $SpawnPoint1
@onready var spawn_point_2 = $SpawnPoint2
@onready var winner_label = $WinnerLabel
@onready var time_label = $TimeLabel

## Referências aos jogadores
var player1: Node2D = null
var player2: Node2D = null

func _ready():
	pie_start_x = pie.position.x
	winner_label.visible = false
	time_label.visible = true

	get_tree().paused = true

	var countdown = preload("res://Cenas/Countdown.tscn").instantiate()
	add_child(countdown)
	countdown.connect("countdown_finished", _on_countdown_finished)

	if Global.chosen_players.size() < 2:
		push_error("Erro: Número insuficiente de jogadores selecionados")
		return

	spawn_players()

func _on_countdown_finished():
	get_tree().paused = false
	Global.start_timer()

func _process(delta):
	if game_over or get_tree().paused:
		return

	update_timer(delta)

	if cooldown_timer > 0:
		cooldown_timer -= delta
		return

	var moved = false

	if Input.is_action_just_pressed("move_p1"):
		pie.position.x += pie_movement
		moved = true

	if Input.is_action_just_pressed("move_p2"):
		pie.position.x -= pie_movement
		moved = true

	if moved:
		cooldown_timer = cooldown_time

	pie.position.x = clamp(
		pie.position.x,
		pie_start_x - pie_limit,
		pie_start_x + pie_limit
	)

	update_player_animations()
	check_winner()

func update_timer(delta):
	var time_ended = Global.update_timer(delta)
	time_label.text = "Tempo: %d" % ceil(Global.time_left)

	if time_ended:
		var middle = pie_start_x
		var margin = 20

		if pie.position.x > middle + margin:
			end_game(1)
		elif pie.position.x < middle - margin:
			end_game(2)
		else:
			end_game(0)

func spawn_players():
	for i in range(2):
		var player_path = Global.chosen_players[i]
		var player_scene = load(player_path)
		if not player_scene:
			push_error("Erro ao carregar cena do jogador: ", player_path)
			continue

		var player_instance = player_scene.instantiate()
		if i == 0:
			player_instance.position = spawn_point_1.position
			player_instance.is_player1 = true
			player1 = player_instance
		else:
			player_instance.position = spawn_point_2.position
			player_instance.is_player1 = false
			player2 = player_instance

		add_child(player_instance)

func update_player_animations():
	if not player1 or not player2:
		return

	var normalized_position = (pie.position.x - (pie_start_x - pie_limit)) / (2 * pie_limit)

	if normalized_position > danger_threshold:
		player1.set_animation_state("ganhando")
		player2.set_animation_state("raiva")
	elif normalized_position < (1.0 - danger_threshold):
		player2.set_animation_state("ganhando")
		player1.set_animation_state("raiva")
	else:
		player1.set_animation_state("idle")
		player2.set_animation_state("idle")

func check_winner():
	if pie.position.x >= pie_start_x + pie_limit:
		end_game(1)
	elif pie.position.x <= pie_start_x - pie_limit:
		end_game(2)

func end_game(winner):
	game_over = true
	Global.stop_timer()
	Global.last_winner = winner

	match winner:
		0: winner_label.text = "Tempo esgotado!"
		1: 
			winner_label.text = "Player 1 venceu!"
			player1.set_game_over_state(true)
			player2.set_game_over_state(false)
		2: 
			winner_label.text = "Player 2 venceu!"
			player2.set_game_over_state(true)
			player1.set_game_over_state(false)

	winner_label.visible = true
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Cenas/game_over.tscn")
