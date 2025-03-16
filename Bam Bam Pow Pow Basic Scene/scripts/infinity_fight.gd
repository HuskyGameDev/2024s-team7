## This scene handles all changes to FightBase specific to the Infinity mode
##
## Infinity is a training mode. In it, you fight an immortal sandbag
## Player can gain coins for upgrades without Hospital Bills

extends Node

# Node References
@onready var enemy = $Fight_Base/enemy
@onready var score_label = $score

func _ready():
	# Set fight type to Infinity
	FightDetails.infinity = true

func _process(delta):
	# Set score value
	score_label.text = "Score: " + str(enemy.score)

## SceneSwap to Results when timer ends
func _on_fight_base_timeout():
	SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn") # Swap

# Go to Selection on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
