extends Node




func _on_dez_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 10
	print(Global.tempo)
	$clique.play()
	
  
func _on_vinte_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 20
	print(Global.tempo)
	$clique.play()

func _on_trinta_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 30
	print(Global.tempo)
	$clique.play()
