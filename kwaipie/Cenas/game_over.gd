extends CanvasLayer

# Referências
@onready var spawn_point_1: Node2D = $spawnPointPlayer1
@onready var spawn_point_2: Node2D = $spawnPointPPlayer2
@onready var winner_label: Label = $WinnerLabel

# Jogadores
var player1: CharacterBody2D = null
var player2: CharacterBody2D = null

func _ready():
	if not validate_players():
		return
	
	spawn_players()
	display_winner()

func validate_players() -> bool:
	if Global.chosen_players.size() < 2:
		push_error("Erro: Selecione 2 jogadores em Global.chosen_players")
		return false
	return true

func spawn_players():
	for i in range(2):
		var player_instance = create_player(i)
		if not player_instance:
			continue
			
		setup_player(player_instance, i)
		add_child(player_instance)

func create_player(index: int) -> Node:
	var player_scene = load(Global.chosen_players[index])
	if not player_scene:
		push_error("Erro ao carregar jogador: ", Global.chosen_players[index])
		return null
	return player_scene.instantiate()

func setup_player(player: Node, index: int):
	player.position = spawn_point_1.position if index == 0 else spawn_point_2.position
	player.is_player1 = index == 0
	
	if index == 0:
		player1 = player
	else:
		player2 = player


func display_winner():
	# Você pode implementar lógica para mostrar o vencedor aqui
	pass



func _on_cancelar_pressed():
	get_tree().quit()


func _on_recomeçar_pressed():
	get_tree().change_scene_to_file("res://Cenas/start.tscn")
