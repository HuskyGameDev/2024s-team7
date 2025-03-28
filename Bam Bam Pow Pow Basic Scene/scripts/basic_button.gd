## Basic Button:
## This scene is meant to be instanced for all basic box buttons.
## It uses NinePatchRects so that the boxes can be resized as needed.
## This scene handles button hover/press signifiers and emits the
## 'pressed' signal.

## Note:
## ---
## Unlike Sprite2DButton, color changes are done through hardcoded
## images. This is because the shaders are a bit ugly and I wanted to.
##
## If we want to be able to change the texture just swap the commented
## and uncommented code on button commands below. This will change it
## to shaders.

extends NinePatchRect
signal buttonPressed

@onready var button = $Button
@onready var audio = $ButtonAudio
@export var tooltip: String

## Preload the image resources for basic/hover/pressed boxes
var basicBox = preload("res://resources/sprites/button.png")
var pressBox = preload("res://resources/sprites/button-just-pressed.png")
var hoverBox = preload("res://resources/sprites/button-hover.png")
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Snap = preload("res://resources/sounds/Snap.mp3")

var hover = false	# Variable for showing if hovering

func _ready() -> void:
	self.set_texture(basicBox)
	#button.tooltip_text = tooltip

# Only signal leaving scene, connect to parent scene like any other button press
func _on_button_pressed():
	buttonPressed.emit()			# Emits buttonPressed signal


## Color changes for hover/press using image change:
## (using shader commented out)

##-----------
## Determine if button pressed; change image accordingly

func _on_button_button_up():		# On press removed:
	# Determine if hovering and set to correct image:
	if hover:	# AND hovering still
		self.set_texture(hoverBox)	# Set texture to hover
	else:		# AND not hovering anymore
		self.set_texture(basicBox)	# Set texture to basic
	#self.material.set_shader_parameter("onoffMult",0)		# Remove multiply

func _on_button_button_down():	# On press:
	self.set_texture(pressBox)	# Set texture to press
	audio.stream = WOOD_CLICK
	if (audio.volume_db != 0):
		audio.volume_db = 0
	audio.play()
	#self.material.set_shader_parameter("onoffMult",1)		# Add multiply


##-----------
## Determine if button hovered; change image accordingly

func _on_button_mouse_entered():		# On hover:
	self.set_texture(hoverBox)		# Set texture to hover
	hover = true		# Is hovering
	audio.stream = Snap
	if (audio.volume_db != -10):
		audio.volume_db = -10
	audio.play()
	#self.material.set_shader_parameter("onoffSoftLight",1)		# Add soft light

func _on_button_mouse_exited():		# On hover removed:
	self.set_texture(basicBox)		# Set texture to basic
	hover = false	# Is not hovering
	#self.material.set_shader_parameter("onoffSoftLight",0)		# Add soft light
