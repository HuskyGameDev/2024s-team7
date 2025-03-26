## Sprite2D Button:
## This scene is meant to be instanced for all 'special'
## buttons that require their own 2D sprite. This scene handles
## button hover/press signifiers and emits the 'pressed' signal.

## Unlike BasicButton, color changes are done through shaders. Not hardcoded images.
## This is a bit uglier...

extends Sprite2D
signal SpriteButtonPressed
signal mouse_entered
signal mouse_exited
@onready var button = $Button
@onready var hoverDivider = (self.hframes * self.vframes)/ 2

@export var hoverWhiteStandard = false
@onready var audio = $AudioPlayer
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Snap = preload("res://resources/sounds/Snap.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make button resize to Sprite2d given image
	button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

# Only signal leaving scene, connect to parent scene like any other button press
func _on_button_pressed():
	SpriteButtonPressed.emit()	# Emits buttonPressed signal
	#print("emit")	# Test if button is emitting
	audio.stream = WOOD_CLICK
	if (audio.volume_db != 0):
		audio.volume_db = 0
	audio.play()
	
## Color changes for hover/press using selfLayerEffects shader:

##-----------
## Determine if pressed, add multiply

func _on_button_button_down():		# Pressed
	self.material.set_shader_parameter("onoffMult",1)		# Add multiply
	
func _on_button_button_up():		# Removed Press
	self.material.set_shader_parameter("onoffMult",0)		# Remove multiply
	

##-----------
## Determine if hover, add white outline and softlight

func hoverWhite():
	self.frame = frame + hoverDivider

func removeWhite():
	self.frame = frame - hoverDivider

func _on_button_mouse_entered():	# Hovering
	self.material.set_shader_parameter("onoffSoftLight",1)		# Add soft light
	audio.stream = Snap
	if (audio.volume_db != -10):
		audio.volume_db = -10
	audio.play()
	if hoverWhiteStandard:
		hoverWhite()
	emit_signal("mouse_entered")
	

func _on_button_mouse_exited():		# Removed Hover
	self.material.set_shader_parameter("onoffSoftLight",0)		# Remove soft light
	if hoverWhiteStandard:
		removeWhite()
	emit_signal("mouse_exited")
