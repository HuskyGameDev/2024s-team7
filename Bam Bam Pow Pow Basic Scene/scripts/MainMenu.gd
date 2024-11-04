extends Control

@onready var index = 0

var buttonList = [0,1,
2,3]

func _ready():
	$"VBoxContainer/New Unlimited".grab_focus()

func _input(event):
	if event is InputEventKey && event.pressed:
		print(buttonList[index])
		if event.as_text_keycode() == "W":
			index = index - 1
			if index < 0:
				index = 3
		if event.as_text_keycode() == "S":
			index = index + 1
			if index > 3:
				index = 0
		print(buttonList[index])
	
func _on_new_unlimited_button_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")

func _on_unlimited_button_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")

func _on_controls_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/ControlsScreen.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

## Campaign Buttons Not Here Yet
func _on_new_campaign_pressed():
	ItemStorage.restart_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")

func _on_load_campaign_pressed():
	ItemStorage.load_game()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn")
	
