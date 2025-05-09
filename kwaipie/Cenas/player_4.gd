# player.gd
extends CharacterBody2D

@onready var animated_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var indicator_label: Label = $PlayerIndicator

@export var player_scene_path: String = "res://Cenas/player_4.tscn"

func _ready():
	if animated_player:
		animated_player.play("idle")
	else:
		printerr("AnimatedSprite2D não encontrado")
