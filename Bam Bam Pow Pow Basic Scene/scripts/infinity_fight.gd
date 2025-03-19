## This scene handles all changes to FightBase specific to the Infinity mode
##
## Infinity is a training mode. In it, you fight an immortal sandbag
## Player can gain coins for upgrades without Hospital Bills

extends Node

# Node References
@onready var enemy = $Fight_Base/enemy
@onready var score_label = $CanvasLayer/score

func _ready():
	# Set fight type to Infinity
	FightDetails.infinity = true

# Go to Selection on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		enemy.calc_money()
		SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn") # Swap

# Change header values when Enemy hit
func _on_enemy_hit():
	score_label.text = "Score: " + str(enemy.score)
