extends Button

@onready var input_button = $"."
## Button name correlates to action index value
## There are 77 god damn built in actions in godot

var is_remapping = false
var action_to_remap = null
var remapping_button = null
var buttonName = null
var actionList = null

func _ready() -> void:
	buttonName = str($".").split(":")
	actionList = InputMap.get_actions()
	_generate()

func _generate():
	var n = int(buttonName[0])
	var action_lab = input_button.find_child("ActionL")
	var input_lab = input_button.find_child("InputL")
	action_lab.text = actionList[n]
	var events = InputMap.action_get_events(actionList[n])
	if events.size() > 0:
		input_lab.text = events[0].as_text()
	else:
		input_lab.text = ""
	input_button.pressed.connect(_on_input_button_pressed.bind(input_button, n))
	
	
func _on_input_button_pressed(button, action):
		if  !(Global.is_remapping) && !is_remapping:
			Global.is_remapping = true
			is_remapping = true
			action_to_remap = action
			remapping_button = button
			button.find_child("InputL").text = "Press key to rebind..."
			
func _input(event):
	var input_lab = input_button.find_child("InputL")
	if Global.is_remapping && is_remapping:
		if (event is InputEventKey):
			InputMap.action_erase_events(actionList[action_to_remap])
			InputMap.action_add_event(actionList[action_to_remap], event)
			input_lab.text = event.as_text()
			Global.is_remapping = false
			is_remapping = false
