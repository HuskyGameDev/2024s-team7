extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _physics_process(delta: float) -> void:
	var direction: Vector2
	direction.x = Input.get_action_strength("R") - Input.get_action_strength("L") 
	direction.y = Input.get_action_strength("D") - Input.get_action_strength("U")
	var movement = Global.MOUSE_SPEED * direction * delta
	if (movement):
		get_viewport().warp_mouse(get_global_mouse_position()+movement)
	if Input.is_action_just_pressed("Light"):
		simulate_mouse_click()

func simulate_mouse_click():
	var mp = get_viewport().get_mouse_position()
	
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.position = mp
	event.pressed = true
	
	Input.parse_input_event(event)
	
	var r_event = InputEventMouseButton.new()
	r_event.button_index = MOUSE_BUTTON_LEFT
	r_event.position = mp
	r_event.pressed = false
	
	Input.parse_input_event(r_event)

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
	
