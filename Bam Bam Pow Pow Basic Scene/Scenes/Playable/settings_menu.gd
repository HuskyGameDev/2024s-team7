extends Control

@export var video_settings: NinePatchRect
@export var audio_settings: NinePatchRect
@export var controls_settings: NinePatchRect



## This function opens and closes the video settings when the corresponding
## buttons are pressed.
##
## Parameters:
## void: This is a signal without any parameters and a single action to perform.
##
## Retruns:
## void: This function performs its action without a return.
func _on_video_settings_button() -> void:
	self.visible = !self.visible
