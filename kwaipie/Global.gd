extends Node

# Variáveis globais
var chosen_players := []
var tempo = 0          # Tempo selecionado na cena Time
var time_left = 0      # Tempo restante atual
var timer_running = false
var last_winner = 0    # 0 = tempo esgotado/empate, 1 = player1, 2 = player2,

# Funções do timer
func start_timer():
	time_left = tempo
	timer_running = true

func stop_timer():
	timer_running = false

func update_timer(delta):
	if timer_running and time_left > 0:
		time_left -= delta
		if time_left <= 0:
			time_left = 0
			timer_running = false
			return true  # Tempo acabou
	return false
