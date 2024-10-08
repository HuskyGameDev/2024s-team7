## This class represents all light and heavy attacks in the game.
## It contains information regarding the attack and its implications.
class_name Attack

## The damage of the attack.
var damage: float

## The multiplier for the damage
var mult: float = 1

## The strength of the knockback.
var knockback: float

## The angle in degrees at which the knockback is applied.
var angle: float

## The milliseconds of hit stun this attack inflicts.
var hit_stun: int

## This is the type of damage that this attack deals.
## TODO: Create a way to reference global types throughout code.
var damage_type: String

## The path to the animation for this attack.
var animation: String = "path/to/debug/anim"

## Initializes the values for the attack instance.
##
## Parameters:
## damage		float: The damage dealt by the attack.
## knockback	float: The strength of the knockback.
## angle		float: The angle in degrees at which the knockback is applied.
## hit_stun		int: The milliseconds of hit stun this attack inflicts.
## damage_type	String: The type of damage dealt.
## animation	String: The path to the animation of the attack. The deault is
## a debug animation.
##
## Returns:
## void: This function is a constructor which does not need to return anything.
func _init(damage: float, knockback: float, angle: float,
		   hit_stun: int, damage_type: String, animation: String) -> void:
	self.damage = damage
	self.knockback = knockback
	self.angle = angle
	self.hit_stun = hit_stun
	self.damage_type = damage_type
	self.animation = animation

## Print out a single attack
func print_attack():
	print("	Damage: " + str(self.damage))
	print("	Multiplier: " + str(self.mult))
	print("	Knockback: " + str(self.knockback))
	print("	Angle: " + str(self.angle))
	print("	Hit Stun: " + str(self.hit_stun))
	print("	Damage Type: " + str(self.damage_type))
	print("	Animation Path: \"" + self.animation + "\"")
