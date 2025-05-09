extends Control

var selected_players: Array[String] = []  # Caminhos dos jogadores selecionados
var player_instances: Array[Node] = []  # Instâncias dos personagens

@onready var container: Node = $Players
@onready var confirm_button: Button = $ConfirmButton

func _ready():
	# Coleta os personagens dentro do contêiner
	player_instances = container.get_children()

	# Conecta o sinal de clique de cada jogador à função local
	for player in player_instances:
		if player.has_signal("player_clicked"):
			player.connect("player_clicked", Callable(self, "_on_player_pressed"))
		else:
			printerr("O player não tem o sinal 'player_clicked': ", player.name)

	# Conecta o botão de confirmação com segurança
	confirm_button.pressed.connect(Callable(self, "on_confirm_pressed"))

func _on_player_pressed(player_node):
	var player_path = player_node.player_scene_path

	if selected_players.has(player_path):
		selected_players.erase(player_path)
		print("Removido:", player_path)
	else:
		if selected_players.size() < 2:
			selected_players.append(player_path)
			print("Adicionado:", player_path)
		else:
			print("Máximo de 2 jogadores atingido.")

	update_player_indicators()

func update_player_indicators():
	for player in player_instances:
		var label = player.get_node("PlayerIndicator")
		var path = player.player_scene_path

		if selected_players.size() > 0 and selected_players[0] == path:
			label.text = "1P"
		elif selected_players.size() > 1 and selected_players[1] == path:
			label.text = "2P"
		else:
			label.text = ""

func on_confirm_pressed():
	if selected_players.size() == 2:
		Global.chosen_players = selected_players.duplicate()
		print("Jogadores escolhidos:", selected_players)
		get_tree().change_scene_to_file("res://Cenas/time.tscn")
	else:
		print("Escolha exatamente 2 jogadores.")
