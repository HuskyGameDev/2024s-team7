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
var motion = -1

var damage = []

## This is the signal to be caught by the damage handler
signal attack_index(index)
signal attack_damamge(damage_number)

@onready
var cooldown_timer = $CoolDownTimer

func _on_enemy_damage_readied(damage_array):
	damage = damage_array
	
func validate_combo(index):
	if damage[index] > 0:
		#attack_index.emit(index)
		#attack_damamge.emit(damage[index])
		print("Core: " + str(core))
		print("Motion: " + str(motion))
		attack_index.emit(0)
		attack_damamge.emit(10)

## This function validates if a given combo is able to be performed and emits a signal corresponding to the index of the given attack
func index_combo():
	var index = -1
	match core:
		CORE.LIGHT:
			index = CORE.LIGHT
		CORE.HEAVY:
			index = CORE.HEAVY
		CORE.SPECIAL:
			index = CORE.SPECIAL
		CORE.SUPER:
			index = CORE.SUPER
	
	if motion != -1:
		match motion:
			MOTION.NEUTRAL:
				index += MOTION.NEUTRAL
			MOTION.UP:
				index += MOTION.UP
			MOTION.DOWN:
				index += MOTION.DOWN
			MOTION.SIDE:
				index += MOTION.SIDE
				
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
		return MOTION.SIDE
	else:
		return MOTION.NEUTRAL

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
			load_combo(CORE.LIGHT)
		elif InputMap.event_is_action(event, "Kick"):
			load_combo(CORE.HEAVY)
		elif InputMap.event_is_action(event, "Weapon"):
			load_combo(CORE.SPECIAL)
		elif InputMap.event_is_action(event, "Special"):
			load_combo(CORE.SUPER)


func _on_player_delay(delaytimer):
	cooldown_timer.stop()
	cooldown_timer.start(delaytimer)
