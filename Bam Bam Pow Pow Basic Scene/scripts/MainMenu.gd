extends Control

##Start Button Pressed
func _on_new_game_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")
 
func _on_load_game_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")
	
##Start Button Pressed
func _on_new_campaign_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")

func _on_load_campaign_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")
	
##Settings Button Pressed
func _on_settings_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

##Quit Button Pressed
func _on_quit_pressed():
	get_tree().quit()
