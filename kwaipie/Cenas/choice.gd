extends Control

var selected_players := []  # Caminhos das cenas dos jogadores selecionados
var selected_buttons := []  # Referência aos botões selecionados

@onready var confirm_button = $ConfirmButton

func _ready():
	# Percorre todos os nós filhos diretos da cena e conecta os botões com nome "bplayer*"
	for child in get_children():
		if child is Button and child.name.begins_with("bplayer"):
			child.connect("pressed", Callable(self, "_on_button_pressed").bind(child))

	# Conecta o botão de confirmação
	confirm_button.connect("pressed", Callable(self, "on_confirm_pressed"))

# Quando um botão é pressionado, esse método é chamado
func _on_button_pressed(button):
	var player_name = button.name  # Ex: bplayer1
	var player_number = player_name.substr(7, player_name.length() - 7)  # Extrai o número do jogador (1, 2, 3, ...)
	var player_path = "res://Cenas/player_" + player_number + ".tscn"  # Caminho correto para a cena do jogador

	if selected_players.has(player_path):
		# Já está selecionado → desmarca
		selected_players.erase(player_path)
		selected_buttons.erase(button)
		button.modulate = Color(1, 1, 1)  # Branco
		print("Jogador removido:", player_path)
	else:
		# Marca até dois jogadores
		if selected_players.size() < 2:
			selected_players.append(player_path)
			selected_buttons.append(button)
			if selected_players.size() == 1:
				button.modulate = Color(0, 0, 1)  # Azul
			elif selected_players.size() == 2:
				button.modulate = Color(1, 0, 0)  # Vermelho
			print("Jogador adicionado:", player_path)
 
	update_button_labels()
# Atualiza os textos nos indicadores dos jogadores
func update_button_labels():
	for child in get_children():
		if child is Button and child.name.begins_with("bplayer") and child.has_node("PlayerIndicator"):
			var label = child.get_node("PlayerIndicator")
			var player_number = child.name.substr(7, child.name.length() - 7)  # Extrai o número do jogador
			var path = "res://Cenas/player_" + player_number + ".tscn"  # Caminho correto para a cena do jogador
			if selected_players.size() > 0 and selected_players[0] == path:
				label.text = "1P"
			elif selected_players.size() > 1 and selected_players[1] == path:
				label.text = "2P"
			else:
				label.text = ""

# Quando o botão de confirmação for pressionado
func on_confirm_pressed():
	if selected_players.size() == 2:
		Global.chosen_players = selected_players.duplicate()  # Guarda os jogadores selecionados
		print("Jogadores selecionados:", selected_players)
		get_tree().change_scene_to_file("res://Cenas/time.tscn")  # Vai para a cena do jogo
	else:
		print("Escolha exatamente 2 jogadores.")
