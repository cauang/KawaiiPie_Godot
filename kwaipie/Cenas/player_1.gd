extends CharacterBody2D

@onready var click_area = $ClickArea  # Acessa o nó ClickArea
@onready var animated_player = $AnimatedSprite2D  # Acessa o nó AnimatedSprite2D
@export var player_scene_path: String = "res://Cenas/player_1.tscn"  # Caminho da cena do personagem

signal player_clicked(player_node)

func _ready():
	# Verifica se o ClickArea existe e conecta o sinal de input_event corretamente
	if click_area:
		click_area.connect("input_event", Callable(self, "_on_click_area_input_event"))
	else:
		printerr("Erro: ClickArea não encontrado para o jogador.")
	
	# Toca a animação inicial
	if animated_player:
		animated_player.play("boy1")  # Substitua "boy1" se necessário
	else:
		printerr("Erro: AnimatedSprite2D não encontrado.")

# Esta função será chamada quando o usuário clicar na ClickArea
func _on_click_area_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		player_clicked.emit(self)
		print("Jogador clicado: ", player_scene_path)
