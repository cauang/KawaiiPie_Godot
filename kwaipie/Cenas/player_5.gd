# player.gd
extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var indicator_label: Label = $PlayerIndicator

@export var player_scene_path: String = "res://Cenas/player_5.tscn"

func _ready():
	if animated_player:
		animated_player.play("boy3")
	else:
		printerr("AnimatedSprite2D não encontrado")
