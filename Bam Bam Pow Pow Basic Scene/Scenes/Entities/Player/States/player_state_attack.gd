extends State
class_name PlayerAttacking
var weapon: Weapon
@export var finished: int
@export var cancel: int
@export var x_momentum: int
@export var y_momentum: int
var attack: String

## This enum is for the core ability
## NOTE: The assigned values are equal to their index in the damage array
enum CORE {
	LIGHT,
	HEAVY,
	SPECIAL,
	SUPER
}

## This enum specifies the motion being input at the time that an attack was pressed.
## NOTE: This has the value of 1...4 inclusive to be used for interpretation with the core ability
enum MOTION {
	NEUTRAL,
	UP,
	DOWN,
	SIDE
}


func Enter():
	print("State: ATTACK")
	weapon = get_parent().weapon
	finished = 0
	cancel = 0
	x_momentum = 0
	y_momentum = 0
	pass

func Update(delta : float):
	player.move_and_slide()
	if(finished == 1):
		if(!player.is_on_floor()):
			state_transition.emit(self,"Air")
		else:
			state_transition.emit(self,"Idle")
				
	if (x_momentum != 0 or y_momentum != 0):
		player.velocity.x = x_momentum
		player.velocity.y -= y_momentum
	

func _on_player_attack_index(core, motion):
	print(str(cancel))
	if(cancel != -1):
		if player.is_on_floor():
			match [core, motion]:
				[CORE.LIGHT, MOTION.NEUTRAL]:
					attack = weapon.light_neutral.animation
				[CORE.LIGHT, MOTION.UP]:
					attack = weapon.light_up.animation
				[CORE.LIGHT, MOTION.DOWN]:
					attack = weapon.light_down.animation
				[CORE.LIGHT, MOTION.SIDE]:
					attack = weapon.light_side.animation
				[CORE.HEAVY, MOTION.NEUTRAL]:
					attack = weapon.heavy_neutral.animation
				[CORE.HEAVY, MOTION.UP]:
					attack = weapon.heavy_up.animation
				[CORE.HEAVY, MOTION.DOWN]:
					attack = weapon.heavy_down.animation
				[CORE.HEAVY, MOTION.SIDE]:
					attack = weapon.heavy_side.animation
				_:
					print("Attack Does Not Exist")
		else:
			match core:
				CORE.LIGHT:
					attack = weapon.light_air.animation
				CORE.HEAVY:
					attack = weapon.heavy_air.animation
		if(cancel > 0):
			attack += "_" + str(cancel)
			
		if animator.has_animation(attack):
			print(attack + " " + str(cancel))
			player.velocity.x = 0
			player.velocity.y = 0
			animator.stop()
			animator.play(attack)
		else:
			pass
