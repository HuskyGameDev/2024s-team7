extends State
class_name PlayerAir

const SPEED = 150.0

func Enter():
	animator.play("un_fall")
	print("State: AIR")
	pass

	
func Update(_delta : float):	
	player.transform.x.x = player.dir 
	var direction = Input.get_axis("L", "R")
	if direction:
		player.velocity.x = direction * SPEED
	if player.is_on_floor():
		state_transition.emit(self,"Idle")
		
	player.move_and_slide()


func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
