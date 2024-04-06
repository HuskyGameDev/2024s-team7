extends Control

func _ready() -> void:
	$TabContainer/Video/CheckButton.button_pressed = Global.fullscreen_on
	$TabContainer/Video/OptionButton.selected = Global.resolution_index
	
func _on_button_pressed():
	SceneSwap.scene_swap(Global.prev_scene)

func _on_check_button_toggled(toggled_on):
	Global.fullscreen_on = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_option_button_item_selected(index):
	Global.resolution_index = index
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(2560, 1440))
		1:
			DisplayServer.window_set_size(Vector2i(1920, 1200))
		2:
			DisplayServer.window_set_size(Vector2i(1366, 768))
		3:
			DisplayServer.window_set_size(Vector2i(1280, 720))
