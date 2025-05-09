extends Control

var selected_players := []
var player_instances := []

@onready var container = $Players
@onready var confirm_button = $ConfirmButton

#func _ready():
	#player_instances = container.get_children()
	#
	#for player in player_instances:
		#player.connect("pressed", _on_player_pressed.bind(player))
#
	#confirm_button.pressed.connect(on_confirm_pressed)

#func _on_player_pressed(player_node):
#	var player_path = player_node.scene_file_path
	
#	if selected_players.has(player_path):
#		selected_players.erase(player_path)
#	else:
#		if selected_players.size() < 2:
#			selected_players.append(player_path)
	
#	update_player_indicators()

#func update_player_indicators():
#	for player in player_instances:
#		var label = player.get_node("PlayerIndicator")
#		var path = player.scene_file_path
#		
#		if selected_players.size() > 0 and selected_players[0] == path:
#			label.text = "1P"
#		elif selected_players.size() > 1 and selected_players[1] == path:
#			label.text = "2P"
#		else:
#			label.text = ""

func on_confirm_pressed():
	if selected_players.size() == 2:
		Global.chosen_players = selected_players.duplicate()
		#get_tree().change_scene_to_file("res://Cenas/time.tscn")
	else:
		print("Escolha exatamente 2 jogadores.")
		#get_tree().change_scene_to_file("res://Cenas/time.tscn")


func _on_confirm_button_pressed():
	get_tree().change_scene_to_file("res://Cenas/time.tscn")
