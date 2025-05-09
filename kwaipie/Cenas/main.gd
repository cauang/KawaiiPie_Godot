extends Node

var pie_movement = 15
var pie_start_x = 0
var pie_limit = 375

var game_over = false
var cooldown_time = 0.02
var cooldown_timer = 0.0

@onready var pie = get_node("Pie")
@onready var spawn_point_1 = $SpawnPoint1
@onready var spawn_point_2 = $SpawnPoint2

func _ready():
	pie_start_x = pie.position.x

	# Verifique se a variável 'chosen_players' está correta
	if Global.chosen_players.size() < 2:
		print("Erro: jogadores não selecionados corretamente.")
		return
	
	# Tente instanciar os jogadores a partir dos caminhos armazenados em 'Global.chosen_players'
	spawn_players()

func spawn_players():
	# Tente instanciar cada jogador usando os caminhos fornecidos em 'Global.chosen_players'
	for i in range(2):
		var scene_path = Global.chosen_players[i]
		var player_scene = load(scene_path)  # Carrega a cena do jogador
		
		# Verifique se a cena foi carregada com sucesso
		if player_scene:
			var player_instance = player_scene.instantiate()  # Cria a instância do jogador
			if i == 0:
				player_instance.position = spawn_point_1.position  # Coloca o 1P no ponto de spawn 1
			else:
				player_instance.position = spawn_point_2.position  # Coloca o 2P jogador 2 no ponto de spawn 2

			# Adiciona a instância do jogador à cena principal
			add_child(player_instance)
		else:
			print("Erro ao carregar cena para jogador:", scene_path)

func _process(delta):
	if game_over:
		return

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
	
	var min_x = pie_start_x - pie_limit
	var max_x = pie_start_x + pie_limit
	pie.position.x = clamp(pie.position.x, min_x, max_x)
	
	check_wall_contact_winner()
	if game_over:
		get_tree().change_scene_to_file("res://Cenas/game_over.tscn")

func check_wall_contact_winner():
	if pie.position.x >= pie_start_x + pie_limit:
		show_winner(1)
	elif pie.position.x <= pie_start_x - pie_limit:
		show_winner(2)

func show_winner(player):
	game_over = true
	$WinnerLabel.text = "Jogador " + str(player) + " venceu!"
	$WinnerLabel.visible = true
