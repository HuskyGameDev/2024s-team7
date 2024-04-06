extends Node

enum ACTION {
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

var action = {
	tag = null,
	time = null
}

var combo = [null, null]

@onready
var cooldown_timer = $CoolDownTimer

func temp(tag) -> bool:
	return false

# This function will validate that the given punch combo is one the player has access to.
# NOTE: Only called when the `combo` array is guaranteed to be full.
func punch_validate(tag) -> bool:
	match tag:
			MOTION.DOWN:
				combo[0] = null
				return true
	return false

# This function will attempt to do a combo attack.
# NOTE: Only called when the `combo` array is guaranteed to be full.
func attempt_combo():
	match combo[0].tag:
		ACTION.PUNCH:
			if punch_validate(combo[1].tag):
				cooldown_timer.start()
				print_debug("Punch!!!")

		ACTION.KICK:
			if temp(combo[0].tag):
				print_debug("Kick!!!")

		ACTION.WEAPON:
			if temp(combo[0].tag):
				print_debug("Weapon!!!")

		ACTION.SPECIAL:
			if temp(combo[0].tag):
				print_debug("Special!!!")

# This will attempt to fill the `combo` array with the current action.
# NOTE: Only called when a valid input was made.
func make_combo():
	if combo[0] == null:
		combo[0] = action.duplicate()
	elif (action.time - combo[0].time) < 500:
		combo[1] = combo[0]
		combo[0] = action.duplicate()
	else:
		combo[0] = action.duplicate()
		combo[1] = null
	
	if combo[1] != null:
		attempt_combo()
	return

func parse_event(input_map):
	match input_map:
		"Punch":
			action.tag = ACTION.PUNCH
			action.time = Time.get_ticks_msec()
		"Kick":
			action.tag = ACTION.KICK
			action.time = Time.get_ticks_msec()
		"Weapon":
			action.tag = ACTION.WEAPON
			action.time = Time.get_ticks_msec()
		"Special":
			action.tag = ACTION.SPECIAL
			action.time = Time.get_ticks_msec()
		"U":
			action.tag = MOTION.UP
			action.time = Time.get_ticks_msec()
		"D":
			action.tag = MOTION.DOWN
			action.time = Time.get_ticks_msec()
		"L":
			action.tag = MOTION.LEFT
			action.time = Time.get_ticks_msec()
		"R":
			action.tag = MOTION.RIGHT
			action.time = Time.get_ticks_msec()
	make_combo()

# This will wait for user input and then assign the appropriate tag and time to the `action` variable.
func _input(event):
	if event is InputEventKey and cooldown_timer.is_stopped():
		for input_map in InputMap.get_actions():
			if InputMap.event_is_action(event, input_map):
				parse_event(input_map)
				return
