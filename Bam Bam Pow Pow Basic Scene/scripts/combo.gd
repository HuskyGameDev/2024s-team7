extends Node

enum ATTACK {
	PUNCH = 0,
	KICK = 1,
	WEAPON = 2,
	SPECIAL = 3
}

enum MOTION {
	UP = 4,
	DOWN = 5,
	LEFT = 6,
	RIGHT = 7
}

var attack = null
var motion = -1

@onready
var cooldown_timer = $CoolDownTimer

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

## This function validates if a given combo is able to be performed
func validate_combo():
	match attack:
		ATTACK.PUNCH:
			match motion:
				MOTION.UP:
					print_debug("Uppercut attack")

func load_combo(attack_tag) -> void:
	attack = attack_tag
	motion = check_motion()
	cooldown_timer.start()
	if motion == -1:
		print_debug("Regular attack")
	else:
		validate_combo()

# This will wait for user input and then assign the appropriate tag and time to the `move` variable.
func _input(event):
	if cooldown_timer.is_stopped():
		if InputMap.event_is_action(event, "Punch"):
			load_combo(ATTACK.PUNCH)
		elif InputMap.event_is_action(event, "Kick"):
			load_combo(ATTACK.KICK)
		elif InputMap.event_is_action(event, "Weapon"):
			load_combo(ATTACK.WEAPON)
		elif InputMap.event_is_action(event, "Special"):
			load_combo(ATTACK.SPECIAL)
