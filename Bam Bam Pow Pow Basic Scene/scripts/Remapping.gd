extends Button

@onready var input_button = $"."

var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready() -> void:
	_generate()

func _generate():
	var action_lab = input_button.find_child("ActionL")
	var input_lab = input_button.find_child("InputL")
	action_lab.text = "P"
	var events = InputMap.action_get_events("P")
	if events.size() > 0:
		input_lab.text = events[0].as_text()
	else:
		input_lab.text = ""
	input_button.pressed.connect(_on_input_button_pressed.bind(input_button, 0))
	print("RAN")
	
	
func _on_input_button_pressed(button, action):
		if  !is_remapping:
			is_remapping = true
			action_to_remap = action
			remapping_button = button
			button.find_child("InputL").text = "Press key to rebind..."
			
func _input(event):
	if is_remapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.pressed)):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			
			remapping_button.find_child("InputL").text = event.as_text().trim_suffix(" (Physical)")
			is_remapping = false
			action_to_remap = null
			remapping_button = null
