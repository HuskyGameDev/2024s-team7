extends Node

#Manages pausing the game and showing the settings overlay, very cool, very cool

var settings_scene_path = "res://Scenes/Playable/SettingsMenu.tscn"
var settings_instance = null
var is_paused = false

# Keep a reference to the parent fight scene
var fight_scene

func _ready():
	#Have the game process even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Get a reference to the parent fight scene
	fight_scene = get_parent()
	
	# Preload the settings scene
	var settings_scene = load(settings_scene_path)
	settings_instance = settings_scene.instantiate()
	settings_instance.is_pause_overlay = true  

func pause_game():
	is_paused = true
	# Pause the game
	get_tree().paused = true
	
	# Pause the fight timer
	if fight_scene.timer.is_stopped() == false:
		fight_scene.timer.paused = true
	
	# Add the settings to the canvas
	fight_scene.canvas_layer.add_child(settings_instance)
	
	# Make sure settings is visible
	settings_instance.show()
	
func unpause_game():
	is_paused = false
	
	# Resume the fight timer if it was running before
	if fight_scene.timer.is_stopped() == false:
		fight_scene.timer.paused = false
	
	# Remove settings from the scene
	if settings_instance.get_parent():
		settings_instance.get_parent().remove_child(settings_instance)
	
	# Unpause the game
	get_tree().paused = false
