# player.gd
extends CharacterBody2D

@onready var click_area: Area2D = $ClickArea
@onready var animated_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var indicator_label: Label = $PlayerIndicator

@export var player_scene_path: String = "res://Cenas/player_1.tscn"

signal player_clicked(player_node)

func _ready():
	if click_area:
		click_area.connect("input_event", Callable(self, "_on_click_area_input_event"))
	else:
		printerr("ClickArea não encontrado no jogador: ", name)

	if animated_player:
		animated_player.play("boy1")
	else:
		printerr("AnimatedSprite2D não encontrado")

func _on_click_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clique detectado em: ", name)
		player_clicked.emit(self)
