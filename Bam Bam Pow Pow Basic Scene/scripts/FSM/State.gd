@icon("res://Art/Icons/StateSprite.png")
extends Node
class_name State
var player : CharacterBody2D
var animator : AnimationPlayer

#NOTE This is the State base-class, all our specific states inherits this logic
# DO NOT CHANGE THIS unless you know what you are doing

@warning_ignore("unused_signal")
signal state_transition

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	pass
	
