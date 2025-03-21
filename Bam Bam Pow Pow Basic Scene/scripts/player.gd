extends CharacterBody2D

@export var score: int = 0
@export var y_momentum: int
@export var dir: int
#@onready var animTree : AnimationTree = $AnimationTree
@onready var fsm = $FSM as FiniteStateMachine
#var index #index of the move currently being used
var inputDir #the direction the player is currently holding (used for detecting moves)
var attackType #The type of move the player is currently doing

@onready var weapon: Weapon = Weapon.new(ItemStorage.equipped_weapon)
signal attack_index(index)
signal attack_performed(attack)
signal player_dir(dir)

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
	#animTree.active = true
	weapon.print_weapon()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_hurtbox_area_entered(hitbox):
	var damage = hitbox.motion
	self.score += damage 
	print("Total DMG = " + str(score))

signal delay(delaytime)

func _on_signal_transfer_to_state(core, motion):
		attack_index.emit(core, motion)

func _on_attack_performed(attack):
	attack_performed.emit(attack)

func _on_enemy_x_pos(enemy_pos):
	if position.x > enemy_pos:
		dir = scale.x * -1
		player_dir.emit(-1)
	else:
		dir = scale.x * 1
		player_dir.emit(1)
