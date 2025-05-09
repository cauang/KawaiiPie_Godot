extends CharacterBody2D

signal player_clicked


func _on_ready():
	$AnimatedSprite2D.play("girl2")
	
#func _ready():
	#$ClickArea.input_event.connect(_on_input_event)
#
#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#player_clicked.emit()
