extends Control

func _on_start_pressed():
	SceneSwap.scene_swap("res://main.tscn")


func _on_settings_pressed():
	print("Uncomment and put scene file")
	#get_tree().change_scene_to_file("PUT FILE HERE")


func _on_quit_pressed():
	get_tree().quit()
