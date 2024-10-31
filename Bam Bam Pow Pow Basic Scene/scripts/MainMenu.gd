extends Control
	

	


func _on_new_unlimited_button_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")


func _on_unlimited_button_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")


func _on_settings_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


## Campaign Buttons Not Here Yet
func _on_new_campaign_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")

func _on_load_campaign_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")
	
