extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Chime = preload("res://resources/sounds/StartChime.wav")

# Load the custom images for the mouse cursor.
var arrow_texture = load("res://resources/sprites/cursor/arrow.png")
var ibeam_texture = load("res://resources/sprites/cursor/ibeam.png")
var pointing_hand_texture = load("res://resources/sprites/cursor/pointing-hand.png")
var move_texture = load("res://resources/sprites/cursor/move.png")
var hsize_texture = load("res://resources/sprites/cursor/hsize.png")
var vsize_texture = load("res://resources/sprites/cursor/vsize.png")
var loading_texture = load("res://resources/sprites/cursor/load.png")
var forbidden_texture = load("res://resources/sprites/cursor/forbidden.png")
var help_texture = load("res://resources/sprites/cursor/help.png")
var pan_hand_texture = load("res://resources/sprites/cursor/pan-hand.png")


func _ready():
	# Set cursor shapes
	Input.set_custom_mouse_cursor(arrow_texture)
	Input.set_custom_mouse_cursor(ibeam_texture, Input.CURSOR_IBEAM)
	Input.set_custom_mouse_cursor(pointing_hand_texture, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(move_texture, Input.CURSOR_MOVE)
	Input.set_custom_mouse_cursor(hsize_texture, Input.CURSOR_HSIZE)
	Input.set_custom_mouse_cursor(vsize_texture, Input.CURSOR_VSIZE)
	Input.set_custom_mouse_cursor(loading_texture, Input.CURSOR_WAIT)
	Input.set_custom_mouse_cursor(forbidden_texture, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(help_texture, Input.CURSOR_HELP)
	
	# Set to a cursor not used in our game
	# Because there is no good function to attach it to
	# But I want to set it to some areas :) 
	Input.set_custom_mouse_cursor(pan_hand_texture, Input.CURSOR_CROSS)



# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

func _on_load_game_button_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
	
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
