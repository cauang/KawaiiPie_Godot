extends Node

var pie_movement = 15  # pixels a mover por clique
var pie_start_x = 0
var pie_limit = 375





var game_over = false
var cooldown_time = 0.02  # tempo de delay entre cliques em segundos
var cooldown_timer = 0.0
  
@onready var pie = get_node("Pie")

func _ready():
	pie_start_x = pie.position.x

func _process(delta):
	if game_over:
		return
	
	# Atualiza o timer de cooldown
	if cooldown_timer > 0:
		cooldown_timer -= delta
		return
	
	# Verifica inputs apenas se não estiver em cooldown
	var moved = false
	
	if Input.is_action_just_pressed("move_p1"):
		pie.position.x += pie_movement
		moved = true
	if Input.is_action_just_pressed("move_p2"):
		pie.position.x -= pie_movement
		moved = true
	
	# Se houve movimento, inicia o cooldown
	if moved:
		cooldown_timer = cooldown_time
	
	# Limitar o movimento da torta
	var min_x = pie_start_x - pie_limit
	var max_x = pie_start_x + pie_limit
	pie.position.x = clamp(pie.position.x, min_x, max_x)
	
	# Verifica vitória por contato com as paredes
	check_wall_contact_winner()

func check_wall_contact_winner():
	if pie.position.x >= pie_start_x + pie_limit:
		show_winner(1)
	elif pie.position.x <= pie_start_x - pie_limit:
		show_winner(2)

func show_winner(player):
	game_over = true
	$WinnerLabel.text = "Jogador " + str(player) + " venceu!"
	$WinnerLabel.visible = true
