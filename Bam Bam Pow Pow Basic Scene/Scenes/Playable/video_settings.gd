extends NinePatchRect


## This function handles the toggling of full screen for the game.
##
## Parameters:
## toggled_on	bool: This is the bool representing if the fullscreen button is
##					  toggled on or not.
##
## Returns:
## void: This function performs its action without a return.
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	Global.fullscreen_on = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


## This function handles the toggling of the fight instructions for the game.
##
## Parameters:
## toggled_on	bool: This is the bool representing if the show instructions
##					  button is toggled on or not.
##
## Returns:
## void: This function performs its action without a return.
func _on_show_instructions_toggled(toggled_on: bool) -> void:
	ItemStorage.inputtoggle = toggled_on


## This function handles selecting a different resolution for the game.
##
## Parameters:
## index	int: This is the index of the option that was selected.
##
## Returns:
## void: This function performs its action without a return.
func _on_resolution_option_selected(index: int) -> void:
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
