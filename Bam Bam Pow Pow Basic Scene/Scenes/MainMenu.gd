extends Control

##Start Button Pressed
func _on_start_pressed():
	SceneSwap.scene_swap("res://main.tscn")

##Settings Button Pressed
func _on_settings_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/SettingsMenu.tscn")

##Quit Button Pressed
func _on_quit_pressed():
	get_tree().quit()
