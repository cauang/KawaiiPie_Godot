extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var indicator_label: Label = $PlayerIndicator

@export var player_scene_path: String = "res://Cenas/player_4.tscn"
@export var is_player1: bool = true  # True para P1, False para P2

# Distância de ativação da animação "perdeu" (ajuste conforme necessário)
var danger_threshold: float = 0.7

func _ready():
	if animated_player:
		animated_player.play("idle")
	else:
		printerr("AnimatedSprite2D não encontrado")

func set_animation_intensity(intensity: float):
	# Para P2, invertemos a intensidade
	var actual_intensity = intensity if is_player1 else (1.0 - intensity)
	
	if actual_intensity > danger_threshold:
		animated_player.play("perdeu")
	else:
		animated_player.play("idle")

func set_game_over_state(is_winner: bool):
	if has_node("AnimatedSprite2D"):
		if is_winner:
			$AnimatedSprite2D.play("ganhou")  # Animação de vitória
		else:
			$AnimatedSprite2D.play("pie")  # Animação de derrota
