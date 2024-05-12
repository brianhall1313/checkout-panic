extends Node2D



func _on_start_button_up():
	Global.intensity = 1
	Global.change_state("new")
	get_tree().change_scene_to_file("res://Scenes/checkout.tscn")


func _on_quit_button_up():
	get_tree().quit()


func _on_credits_button_up():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")


func _on_how_to_play_button_up():
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")
