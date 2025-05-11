extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var indicator_label: Label = $PlayerIndicator

@export var player_scene_path: String = "res://Cenas/player_1.tscn"
@export var is_player1: bool = true  # True para P1, False para P2

var current_anim: String = "idle"  # Guarda a animação atual

func _ready():
	if animated_player:
		animated_player.play("idle")
	else:
		printerr("AnimatedSprite2D não encontrado")

# Controla a animação conforme o estado enviado
func set_animation_state(state: String):
	_play_if_not(state)

# Controla a animação final de vitória ou derrota
func set_game_over_state(is_winner: bool):
	if not animated_player:
		return

	if is_winner:
		animated_player.play("ganhou")
	else:
		animated_player.play("pie")

# Toca a animação apenas se for diferente da atual
func _play_if_not(anim_name: String):
	if current_anim != anim_name:
		animated_player.play(anim_name)
		current_anim = anim_name
