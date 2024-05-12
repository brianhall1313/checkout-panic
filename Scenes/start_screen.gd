extends Node2D



func _on_start_button_up():
	Global.intensity = 1
	get_tree().change_scene_to_file("res://Scenes/checkout.tscn")


func _on_quit_button_up():
	get_tree().quit()
