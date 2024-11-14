extends Control
	

	
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Chime = preload("res://resources/sounds/StartChime.wav")

func _on_new_unlimited_button_pressed():
	ItemStorage.restart_game()
	audio_stream_player.stream = Chime
	audio_stream_player.play()
	await get_tree().create_timer(1.0).timeout
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")


func _on_unlimited_button_pressed():
	ItemStorage.load_game()
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")


func _on_settings_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
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
	
