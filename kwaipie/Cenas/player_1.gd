extends CharacterBody2D

#signal player_clicked

func _on_ready():
	$AnimatedSprite2D.play("boy1")
	#var click_area = $ClickArea  
	#if click_area == null:
	#	print("Erro: Não foi possível encontrar o nó ClickArea.")
	#	return
	
	# Conecta o evento de clique
	#click_area.input_event.connect(_on_input_event)
   

#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Emite o sinal de clique quando o jogador é clicado
	#	player_clicked.emit()
