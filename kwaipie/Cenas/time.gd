extends Node




func _on_dez_pressed():
	$clique.play()
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 10
	print(Global.tempo)
	
	
  
func _on_vinte_pressed():
	$clique.play()
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 20
	print(Global.tempo)
	

func _on_trinta_pressed():
	$clique.play()
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 30
	print(Global.tempo)
	
