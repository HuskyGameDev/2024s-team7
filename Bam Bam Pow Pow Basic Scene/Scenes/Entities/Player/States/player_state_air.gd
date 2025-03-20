extends State
class_name PlayerAir
var weapon: Weapon

const SPEED = 150.0

func Enter():
	weapon = get_parent().weapon
	animator.play(weapon.name + "/fall")
	print("State: AIR")
	pass

	
func Update(_delta : float):	
	player.move_and_slide()
	player.transform.x.x = player.dir 
	var direction = Input.get_axis("L", "R")
	if direction:
		player.velocity.x = direction * SPEED	
	if player.is_on_floor():
		state_transition.emit(self,"Idle")
		
func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
