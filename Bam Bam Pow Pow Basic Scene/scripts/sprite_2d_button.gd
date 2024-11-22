## Sprite2D Button:
## This scene is meant to be instanced for all 'special'
## buttons that require their own 2D sprite. This scene handles
## button hover/press signifiers and emits the 'pressed' signal.

## Unlike BasicButton, color changes are done through shaders. Not hardcoded images.
## This is a bit uglier...

extends Sprite2D
signal SpriteButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make button resize to Sprite2d given image
	$Button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

# Only signal leaving scene, connect to parent scene like any other button press
func _on_button_pressed():
	SpriteButtonPressed.emit()	# Emits buttonPressed signal
	#print("emit")	# Test if button is emitting
	
	
## Color changes for hover/press using selfLayerEffects shader:

##-----------
## Determine if multiply on (button pressed)

func _on_button_button_down():		# Pressed
	self.material.set_shader_parameter("onoffMult",1)		# Add multiply
	
func _on_button_button_up():		# Removed Press
	self.material.set_shader_parameter("onoffMult",0)		# Remove multiply
	

##-----------
## Determine if soft light on (button hover)

func _on_button_mouse_entered():	# Hovering
	self.material.set_shader_parameter("onoffSoftLight",1)		# Add soft light

func _on_button_mouse_exited():		# Removed Hover
	self.material.set_shader_parameter("onoffSoftLight",0)		# Remove soft light
