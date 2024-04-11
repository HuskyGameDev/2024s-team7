extends Node

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
	UP = 1,
	DOWN = 2,
	LEFT = 3,
	RIGHT = 4
}

## These are the values containing the core or the motion the user pressed in the current instance
var core = null
var motion = -1

var damage = []

## This is the signal to be caught by the damage handler
signal attack(index, damage)

@onready
var cooldown_timer = $CoolDownTimer

## DEBUG FUNCTION
func _on_attack(index, damage):
	print_debug("Valid attack index: " + str(index) + "\nDamage delt: " + str(damage))

func _on_enemy_damage_readied(damage_array):
	damage = damage_array

func validate_combo(index):
	if damage[index] > 0:
		attack.emit(index, damage[index])

## This function validates if a given combo is able to be performed and emits a signal corresponding to the index of the given attack
func index_combo():
	var index = -1
	match core:
		CORE.PUNCH:
			index = CORE.PUNCH
		CORE.KICK:
			index = CORE.KICK
		CORE.WEAPON:
			index = CORE.WEAPON
		CORE.SPECIAL:
			index = CORE.SPECIAL
	
	if motion != -1:
		match motion:
			MOTION.UP:
				index += MOTION.UP
			MOTION.DOWN:
				index += MOTION.DOWN
			MOTION.LEFT:
				index += MOTION.LEFT
			MOTION.RIGHT:
				index += MOTION.RIGHT
				
	validate_combo(index)
	motion = -1
	core = null

## This function checks if a current motion is being pressed and returns it
func check_motion() -> int:
	if Input.is_action_pressed("U"):
		return MOTION.UP
	elif Input.is_action_pressed("D"):
		return MOTION.DOWN
	elif Input.is_action_pressed("R"):
		return MOTION.RIGHT
	elif Input.is_action_pressed("L"):
		return MOTION.LEFT
	else:
		return -1

## This function will load the attack into given values, begin the cooldown timer, and then validate the combo to emit the signal
func load_combo(core_tag) -> void:
	core = core_tag
	motion = check_motion()
	cooldown_timer.start()
	index_combo()

## This will wait for user input and then attemp to load a combo using the value passed into it
func _input(event):
	if cooldown_timer.is_stopped():
		if InputMap.event_is_action(event, "Punch"):
			load_combo(CORE.PUNCH)
		elif InputMap.event_is_action(event, "Kick"):
			load_combo(CORE.KICK)
		elif InputMap.event_is_action(event, "Weapon"):
			load_combo(CORE.WEAPON)
		elif InputMap.event_is_action(event, "Special"):
			load_combo(CORE.SPECIAL)
