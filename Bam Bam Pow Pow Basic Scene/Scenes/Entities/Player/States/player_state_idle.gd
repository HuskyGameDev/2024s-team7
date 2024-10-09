extends State
class_name PlayerIdle
var weapon: Weapon

func Enter():
	animator.play("un_idle")
	print("State: IDLE")
	weapon = get_parent().weapon
	pass

	
func Update(_delta : float):
	player.transform.x.x = player.dir 
	if(Input.get_axis("L", "R")):
		state_transition.emit(self,"Moving")
		
func _on_player_attack_index(core, motion):
	state_transition.emit(self,"Attacking")
