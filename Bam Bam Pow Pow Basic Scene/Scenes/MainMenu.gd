extends Control

func _on_start_pressed():
	SceneSwap.scene_swap("res://main.tscn")


func _on_settings_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/SettingsMenu.tscn")


func _on_quit_pressed():
	get_tree().quit()
