extends Node

## Configurações do jogo
var pie_movement = 15
var pie_start_x = 0
var pie_limit = 375
var danger_threshold = 0.7  # Limite para animação "perdeu"

## Estado do jogo
var game_over = false
var cooldown_time = 0.02
var cooldown_timer = 0.0

## Referências aos nós
@onready var pie = $Pie
@onready var spawn_point_1 = $SpawnPoint1
@onready var spawn_point_2 = $SpawnPoint2
@onready var winner_label = $WinnerLabel
@onready var time_label = $TimeLabel  # Adicione esta linha (e crie a Label na cena)

## Referências aos jogadores
var player1: Node2D = null
var player2: Node2D = null

func _ready():
	# Configuração inicial
	pie_start_x = pie.position.x
	winner_label.visible = false
	
	# Inicia o timer com o valor definido na cena Time
	Global.start_timer()
	
	# Verificação dos jogadores selecionados
	if Global.chosen_players.size() < 2:
		push_error("Erro: Número insuficiente de jogadores selecionados")
		return
	
	# Spawn dos jogadores
	spawn_players()

func _process(delta):
	if game_over:
		return
	
	# Atualiza o timer (nova adição)
	update_timer(delta)
	
	# Cooldown do movimento
	if cooldown_timer > 0:
		cooldown_timer -= delta
		return
	
	# Controles dos jogadores
	var moved = false
	
	if Input.is_action_just_pressed("move_p1"):
		pie.position.x += pie_movement
		moved = true
	
	if Input.is_action_just_pressed("move_p2"):
		pie.position.x -= pie_movement
		moved = true
	
	# Atualizações do jogo
	if moved:
		cooldown_timer = cooldown_time
	
	# Limita o movimento da torta
	pie.position.x = clamp(
		pie.position.x,
		pie_start_x - pie_limit,
		pie_start_x + pie_limit
	)
	
	# Atualiza animações e verifica vitória
	update_player_animations()
	check_winner()

# NOVA FUNÇÃO PARA ATUALIZAR O TIMER (única adição significativa)
func update_timer(delta):
	# Atualiza o timer global
	var time_ended = Global.update_timer(delta)
	
	# Atualiza a label de tempo
	time_label.text = "Tempo: %d" % ceil(Global.time_left)
	
	# Verifica se o tempo acabou
	if time_ended:
		end_game(0)  # 0 indica tempo esgotado

# (O resto do seu código original permanece EXATAMENTE IGUAL)
func spawn_players():
	# Carrega e instancia os jogadores
	for i in range(2):
		var player_path = Global.chosen_players[i]
		var player_scene = load(player_path)
		
		if not player_scene:
			push_error("Erro ao carregar cena do jogador: ", player_path)
			continue
		
		var player_instance = player_scene.instantiate()
		
		# Configura cada jogador
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
	
	# Calcula a posição normalizada da torta (0 a 1)
	var normalized_position = (pie.position.x - (pie_start_x - pie_limit)) / (2 * pie_limit)
	
	# Atualiza animação do Player 1
	if player1.has_method("set_animation_intensity"):
		player1.set_animation_intensity(normalized_position)
	
	# Atualiza animação do Player 2 (intensidade invertida)
	if player2.has_method("set_animation_intensity"):
		player2.set_animation_intensity(normalized_position)

func check_winner():
	# Verifica se a torta atingiu os limites
	if pie.position.x >= pie_start_x + pie_limit:
		end_game(1)  # Player 1 venceu
	elif pie.position.x <= pie_start_x - pie_limit:
		end_game(2)  # Player 2 venceu

func end_game(winner):
	game_over = true
	Global.stop_timer()  # Nova linha para parar o timer
	
	# Mantém sua lógica original de vitória
	if winner == 0:
		winner_label.text = "Tempo esgotado!"
	else:
		winner_label.text = "Jogador %d venceu!" % winner
	
	winner_label.visible = true
	
	# Muda para a cena de game over após um breve delay
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Cenas/game_over.tscn")
