extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_dez_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 10
	print(Global.tempo)


func _on_vinte_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 20
	print(Global.tempo)



func _on_trinta_pressed():
	get_tree().change_scene_to_file("res://Cenas/Main.tscn")
	Global.tempo = 30
	print(Global.tempo)
