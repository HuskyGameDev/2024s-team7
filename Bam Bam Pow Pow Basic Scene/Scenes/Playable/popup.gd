extends Control

@onready var color_rect = $ColorRect
@onready var label: Label = $ColorRect/Label  

func show_message(text: String) -> void:
	label.text = text 
	visible = true

func hide_popup() -> void: 
	visible = false
