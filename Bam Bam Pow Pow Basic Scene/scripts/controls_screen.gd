extends Node2D

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventKey:
		SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn")
