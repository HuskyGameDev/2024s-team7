extends State
class_name PlayerWalking
var weapon: Weapon

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func Enter():
	weapon = get_parent().weapon
	animator.play(weapon.name + "/walk")
	print("State: WALK")
	pass

func Update(delta : float):
	player.transform.x.x = player.dir 
	var direction = Input.get_axis("L", "R")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = 0
		state_transition.emit(self,"Idle")
		
	#Handle Jumping
	if(Input.is_action_just_pressed("U")):
		player.velocity.y = -500
		state_transition.emit(self,"Air")

	player.move_and_slide()

func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
