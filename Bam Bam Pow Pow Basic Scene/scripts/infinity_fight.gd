## This scene handles all changes to FightBase specific to the Infinity mode
##
## Infinity is a training mode. In it, you fight an immortal sandbag
## Player can gain coins for upgrades without Hospital Bills

extends Node

# Node References
@onready var enemy = $Fight_Base/enemy
@onready var score_label = $CanvasLayer/score
@onready var canvas_layer = $CanvasLayer

var results = preload("res://Scenes/Playable/ResultsScreen.tscn").instantiate()

func _ready():
	# Set fight type to Infinity
	FightDetails.infinity = true

# Go to Selection on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		# Removed for playtest
		#SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
		enemy.calc_money()
		canvas_layer.add_child(results)
		get_tree().paused = true
		
# Change header values when Enemy hit
func _on_enemy_hit():
	score_label.text = "SCORE: " + str(enemy.score)


func _on_exit_button_button_pressed():
	enemy.calc_money()
	canvas_layer.add_child(results)
	get_tree().paused = true
