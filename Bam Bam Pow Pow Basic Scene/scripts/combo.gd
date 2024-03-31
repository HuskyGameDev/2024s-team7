extends Node

enum ACTION {
	PUNCH,
	KICK,
	WEAPON,
	SPECIAL,
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var move = {
	tag = null,
	time = null
}

var combo = [null, null]

func temp(tag) -> bool:
	return false

# This function will validate that the given punch combo is one the player has access to.
# NOTE: Only called when the `combo` array is guaranteed to be full.
func punch_validate(tag) -> bool:
	match tag:
			ACTION.UP:
				return true
	return false

# This function will attempt to do a combo attack.
# NOTE: Only called when the `combo` array is guaranteed to be full.
func attempt_combo():
	match combo[1].tag:
		ACTION.PUNCH:
			if punch_validate(combo[0].tag):
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

# This will attempt to fill the `combo` array with the current move.
# NOTE: Only called when a valid input was made.
func make_combo():
	if combo[0] == null:
		combo[0] = move.duplicate()
	elif (move.time - combo[0].time) < 500:
		combo[1] = combo[0]
		combo[0] = move.duplicate()
	else:
		combo[0] = move.duplicate()
		combo[1] = null
	
	if combo[1] != null:
		attempt_combo()
	return

# This will wait for user input and then assign the appropriate tag and time to the `move` variable.
func _process(delta):
	if Input.is_action_just_pressed("Punch"):
		move.tag = ACTION.PUNCH
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("Kick"):
		move.tag = ACTION.KICK
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("Weapon"):
		move.tag = ACTION.WEAPON
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("Special"):
		move.tag = ACTION.SPECIAL
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("U"):
		move.tag = ACTION.UP
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("D"):
		move.tag = ACTION.DOWN
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("L"):
		move.tag = ACTION.LEFT
		move.time = Time.get_ticks_msec()
		make_combo()
	elif Input.is_action_just_pressed("R"):
		move.tag = ACTION.RIGHT
		move.time = Time.get_ticks_msec()
		make_combo()
	
