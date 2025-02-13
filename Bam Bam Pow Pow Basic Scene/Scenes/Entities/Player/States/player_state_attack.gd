extends State
class_name PlayerAttacking
var weapon: Weapon
@export var finished: int
@export var cancel: String
@export var x_momentum: int
@export var y_momentum: int
var direction: int
var attack: String
var attack_anim: String
signal attack_performed(attack)

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
	direction = player.dir
	print("State: ATTACK")
	weapon = get_parent().weapon
	finished = 0
	cancel = ""
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
		player.velocity.x = x_momentum * direction
		player.velocity.y -= y_momentum
	

func _on_player_attack_index(core, motion):
	if(cancel != "no"):
		if player.is_on_floor():
			match [core, motion]:
				[CORE.LIGHT, MOTION.NEUTRAL]:
					attack = "light_neutral"
				[CORE.LIGHT, MOTION.UP]:
					attack = "light_up"
				[CORE.LIGHT, MOTION.DOWN]:
					attack = "light_down"
				[CORE.LIGHT, MOTION.SIDE]:
					attack = "light_side"
				[CORE.HEAVY, MOTION.NEUTRAL]:
					attack = "heavy_neutral"
				[CORE.HEAVY, MOTION.UP]:
					attack = "heavy_up"
				[CORE.HEAVY, MOTION.DOWN]:
					attack = "heavy_down"
				[CORE.HEAVY, MOTION.SIDE]:
					attack = "heavy_side"
				[CORE.SPECIAL, _]:
					print("No Special for you")
				[CORE.SUPER, _]:
					print("No Super for you")
				_:
					print("Attack Does Not Exist")
		else:
			match core:
				CORE.LIGHT:
					attack = "light_air"
				CORE.HEAVY:
					attack = "heavy_air"
				CORE.SPECIAL:
					pass
				CORE.SUPER:
					pass
		if(cancel != ""):
			attack = cancel
			
		print(attack)
		attack_performed.emit(attack)
		if animator.has_animation(weapon[attack].animation):
			animator.stop()
			attack_anim = weapon[attack].animation
			player.velocity.x = 0
			player.velocity.y = 0
			animator.play(attack_anim)
			print(cancel)
		else:
			pass
