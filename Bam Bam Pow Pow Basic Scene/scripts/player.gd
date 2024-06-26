extends CharacterBody2D

@export var score: int = 0
@onready var animTree : AnimationTree = $AnimationTree
#var index #index of the move currently being used
var inputDir #the direction the player is currently holding (used for detecting moves)
var attackType #The type of move the player is currently doing

## This enum is for the core ability
## NOTE: The assigned values are equal to their index in the damage array
enum CORE {
	PUNCH = 0,
	KICK = 5,
	WEAPON = 10,
	SPECIAL = 15
}
## This enum specifies the motion being input at the time that an attack was pressed.
## NOTE: This has the value of 1...4 inclusive to be used for interpretation with the core ability
enum MOTION {
	NEUTRAL = 0,
	UP = 1,
	DOWN = 2,
	LEFT = 3,
	RIGHT = 4
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animTree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")

func _on_hurtbox_area_entered(hitbox):
	var damage = hitbox.motion
	self.score += damage 
	print("Total DMG = " + str(score))

signal delay(delaytime)
	

func _on_combo_handler_attack_index(index):
	if(index < CORE.PUNCH + 5):
		animTree["parameters/conditions/punch"] = true
		attackType = "punch"
		inputDir = index - CORE.PUNCH
		delay.emit(.1)
	elif(index < CORE.KICK + 5):
		animTree["parameters/conditions/kick"] = true
		attackType = "kick"
		inputDir = index - CORE.KICK
	elif(index < CORE.WEAPON + 5):
		animTree["parameters/conditions/weapon"] = true
		attackType = "weapon"
		inputDir = index - CORE.WEAPON
	elif(index < CORE.SPECIAL + 5):
		animTree["parameters/conditions/special"] = true
		delay.emit(.1)
		attackType = "special"
		inputDir = index - CORE.SPECIAL

	if (inputDir == MOTION.NEUTRAL):
		animTree["parameters/" + attackType + "/conditions/neutral"] = true
	elif(inputDir == MOTION.UP):
		animTree["parameters/" + attackType + "/conditions/up"] = true
	elif(inputDir == MOTION.DOWN):
		animTree["parameters/" + attackType + "/conditions/down"] = true
	elif(inputDir == MOTION.LEFT):
		animTree["parameters/" + attackType + "/conditions/left"] = true
	elif(inputDir == MOTION.RIGHT):
		animTree["parameters/" + attackType + "/conditions/right"] = true
