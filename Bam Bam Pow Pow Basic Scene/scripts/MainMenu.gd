extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Chime = preload("res://resources/sounds/StartChime.wav")

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

func _on_load_game_button_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/InfinityFight.tscn")
	
func _on_new_game_button_pressed():
	FightDetails.infinity = false
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

func _on_tutorial_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/tutorial_fight.tscn")

func _on_settings_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
