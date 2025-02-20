extends Node

@onready var darken = $ColorRect2
@onready var label = $ColorRect2/Label
@onready var buttons = $ColorRect2/VBoxContainer
@onready var animation = $AnimatedSprite2D
@onready var tellSkip = $Label
@onready var newWeap = FightDetails.newWeaponNotification
# Scenario 0: Defeated
# Scenario 1: New Weapon (will be swapped later with 2)
# Scenario 2: Victory

# different animations for different wins and losses sounds hard/like a lot of work :sob: 

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play(FightDetails.animation)
	FightDetails.newWeaponNotification = false
	#get_parent().animationStart.connect(animSelect)

#func animSelect(whichAnim):
	#animation.play(whichAnim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn")

func _on_animated_sprite_2d_animation_finished():
	tellSkip.hide()
	darken.show()
	await get_tree().create_timer(.3).timeout
	label.show()
	await get_tree().create_timer(.01).timeout
	buttons.show()

func _on_yes_button_pressed():	
	if(newWeap):
		darken.hide()
		label.hide()
		buttons.hide()
		animation.play("newWeapon")
	else:
		FightDetails.animation = ""
		SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn")


func _on_no_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn")
