extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var background_index = 0

var fight_background = preload("res://Scenes/Functional/FightBackground.tscn")
@onready var background_instance

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
	
	background_instance = fight_background.instantiate()
	add_child(background_instance)

func _process(delta):
	background_instance.scroll_offset.x -= 20 * delta

func _on_timer_timeout():
	var fade = load("res://Scenes/Functional/fade.tscn").instantiate()
	get_tree().root.add_child(fade)
	fade.layer = 0
	fade.fade_to_black()
	await fade.faded
	background_instance.queue_free()
	background_instance = fight_background.instantiate()
	background_instance.background_setup_function = FightDetails.op_list[background_index]["background_setup_function"]
	add_child(background_instance)
	
	# Had this be dynamic. But it kept breaking. I don't know why this works.... It's 2:38 am.
	if (background_index > 5):
		background_index = 0
	else:
		background_index = background_index + 1
	# Fade out then remove fade scene.
	fade.fade_to_norm()
	await fade.norm
	get_tree().root.remove_child(fade)
	fade.queue_free()

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
	
func _on_new_game_button_pressed():
	FightDetails.infinity = false
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

func _on_load_game_button_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

func _on_tutorial_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/tutorial_fight.tscn")

func _on_settings_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

func _on_credit_button_pressed():
	OS.shell_open("https://github.com/HuskyGameDev/2024s-team7")

func _on_quit_button_pressed():
	get_tree().quit()
