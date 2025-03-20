extends State
class_name PlayerIdle
var weapon: Weapon

func Enter():
	weapon = get_parent().weapon
	animator.play(weapon.name + "/idle")
	print("State: IDLE")
	#weapon = get_parent().weapon
	pass

	
func Update(_delta : float):
	player.transform.x.x = player.dir 
	if(Input.get_axis("L", "R")):
		state_transition.emit(self,"Moving")
		
	 #Handle Jumping
	if(Input.is_action_just_pressed("U")):
		player.velocity.y = -500
		state_transition.emit(self,"Air")
		
func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
