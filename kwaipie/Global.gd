extends Node

# Variáveis globais
var chosen_players := []
var tempo = 0  # Tempo selecionado na cena Time
var time_left = 0  # Tempo restante atual
var timer_running = false  # Estado do temporizador

# Função para iniciar o temporizador
func start_timer():
	time_left = tempo
	timer_running = true

# Função para parar o temporizador
func stop_timer():
	timer_running = false

# Função que atualiza o temporizador (chamar a cada frame)
func update_timer(delta):
	if timer_running and time_left > 0:
		time_left -= delta
		if time_left <= 0:
			time_left = 0
			timer_running = false
			return true  # Retorna true quando o tempo acaba
	return false
