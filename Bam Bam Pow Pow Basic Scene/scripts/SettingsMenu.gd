extends Control

var keylist = [KEY_W, KEY_S, KEY_A, KEY_D, KEY_J, KEY_K, KEY_L, KEY_SEMICOLON]

func _ready() -> void:
	$"TabContainer/Video & Audio/CheckButton".button_pressed = Global.fullscreen_on
	$"TabContainer/Video & Audio/OptionButton".selected = Global.resolution_index

func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap(Global.prev_scene)

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

func _on_reset_remap_pressed() -> void:
	var actionList = InputMap.get_actions() 
	for n in range(77, 85):
		var event = InputEventKey.new()
		InputMap.action_erase_events(actionList[n])
		event.keycode = keylist[n-77]
		InputMap.action_add_event(actionList[n], event)
		var node = get_node("TabContainer/Controls/VBoxContainer/"+str(n)+"/MarginContainer/HBoxContainer/InputL")
		node.text = event.as_text()


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	ItemStorage.inputtoggle = toggled_on
