extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_começar_pressed():
	get_tree().change_scene_to_file("res://Cenas/choice.tscn")
				#MUDAR PARA CENA DE ESCOLHA

func _on_cancelar_pressed():
	get_tree().quit()
