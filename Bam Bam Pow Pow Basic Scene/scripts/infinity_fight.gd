extends Node

@onready var enemy = $Fight_Base/enemy
@onready var score_label = $score


# What we'll need to find a way to handle here:

# Changing score
# Moving to next correct screen

func _ready():
	FightDetails.infinity = true
	# Set opponent health
	enemy.max_health = FightDetails.op_list[FightDetails.op_progress]["health"]



func _process(delta):
	score_label.text = "Score: " + str(enemy.score)

			
func _on_fight_base_timeout():
	SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn")
