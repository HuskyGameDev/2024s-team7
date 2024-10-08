extends State
class_name PlayerWalking

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func Enter():
	animator.play("un_walk")
	print("State: WALK")
	pass

func Update(delta : float):
	var direction = Input.get_axis("L", "R")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		state_transition.emit(self,"Idle")

	player.move_and_slide()

func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
