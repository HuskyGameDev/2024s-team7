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

@onready var button = $"."


# Tween values for button scaling animation
#@onready var tween = get_tree().create_tween()
#@onready tween.tween_property(button, "scale", Vector2(), 1)



## Preload the image resources for basic/hover/pressed boxes
var basicBox = preload("res://resources/sprites/real-box.png")
var pressBox = preload("res://resources/sprites/mult-box.png")
var hoverBox = preload("res://resources/sprites/box-soft-light.png")

var hover = false	# Variable for showing if hovering

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
	#self.material.set_shader_parameter("onoffMult",1)		# Add multiply

##-----------
## Determine if button hovered; change image accordingly

func _on_button_mouse_entered():		# On hover:
	self.set_texture(hoverBox)		# Set texture to hover
	hover = true		# Is hovering
	#self.material.set_shader_parameter("onoffSoftLight",1)		# Add soft light
	
	# tween growth on hover
	button.pivot_offset = button.size/2
	#start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)


func _on_button_mouse_exited():		# On hover removed:
	self.set_texture(basicBox)		# Set texture to basic
	hover = false	# Is not hovering
	#self.material.set_shader_parameter("onoffSoftLight",0)		# Add soft light
	
	button.pivot_offset = button.size/2
	#start_tween(button, "scale", Vector2.ONE, tween_duration)


func start_tween(object: Object, property: String, final_val: Variant, duration: float):
		var tween = create_tween()
		tween.tween_property(object, property, final_val, duration)
		
