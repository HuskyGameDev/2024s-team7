extends Node

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

## These are the values containing the core or the motion the user pressed in the current instance
var core = null
var motion = MOTION.NEUTRAL

var damage = []

## This is the signal to be caught by the damage handler
signal attack_index(index)
signal attack_damamge(damage_number)

## This is the signal to cause a debuff to be applied.
signal change_res(res: String, value: float)

## This is the signal that will be emitted once the player does a vailid attack.
signal attack(core: int, motion: int)

@onready
var cooldown_timer = $CoolDownTimer

func _on_enemy_damage_readied(damage_array):
	damage = damage_array
	
func validate_combo():
	print("Core: " + str(core))
	print("Motion: " + str(motion))
	# TODO: Implement a way to check that the player has access to the given 
	# attack. For example psecial attacks. Off the start the player will not
	# have access to any special attacks.
	attack.emit(core, motion)
	#attack_index.emit(0)
	#attack_damamge.emit(10)


## This function checks if a current motion is being pressed and returns it
func check_motion() -> int:
	if Input.is_action_pressed("U"):
		return MOTION.UP
	elif Input.is_action_pressed("D"):
		return MOTION.DOWN
	elif Input.is_action_pressed("R"):
		return MOTION.SIDE
	elif Input.is_action_pressed("L"):
		return MOTION.SIDE
	else:
		return MOTION.NEUTRAL

## This function will load the attack into given values, begin the cooldown timer, and then validate the combo to emit the signal
func load_combo(core_tag) -> void:
	core = core_tag
	motion = check_motion()
	validate_combo()
	motion = MOTION.NEUTRAL
	core = null

## This will wait for user input and then attemp to load a combo using the value passed into it
func _input(event):
	if cooldown_timer.is_stopped():
		if event.is_action_pressed("Punch", false):
			load_combo(CORE.LIGHT)
		elif event.is_action_pressed("Kick", false):
			load_combo(CORE.HEAVY)
		elif event.is_action_pressed("Weapon", false):
			load_combo(CORE.SPECIAL)
		elif event.is_action_pressed("Special", false):
			load_combo(CORE.SUPER)
		elif event.is_action_pressed("Debuff", false):
			apply_debuff("PHYSICAL", 4.0, -0.5)


## This function will signal for a resistance change on the enemy, after a delay
## it will revert that change.
##
## Parameters:
## type		String: This is the type of resistance that is to be modified.
## duration	float: This is the amount of time that the debuff is applied.
## amount	float: This is the modification to be applied to that resistance. 
##
## Returns:
## void: There is no return, this change is internal.
func apply_debuff(type: String, duration: float, amount: float) -> void:
	change_res.emit(type, amount)
	await get_tree().create_timer(duration).timeout
	change_res.emit(type, -amount)


func _on_player_delay(delaytimer):
	cooldown_timer.stop()
	cooldown_timer.start(delaytimer)
