## This scene is a child of all Fight sequences.
## It holds the player, enemy, background, timer, and combo counter.
## This scene is nearly identical to our previous 'Fight' scene',
## Only change: the damage counter has been moved to InfinityFight

extends Node

signal start

# Variables
var started = false
# Node References
@onready var enemy = $enemy
@onready var player = $player
@onready var combo_label = $CanvasLayer/combo
@onready var time_label = $time
@onready var input_screen = $WarningScreen
@onready var floor = $TileMap


# Calculate score and HP in other infinityDraft and campaignDraft somehow

#func _ready():
	# Set tile texture to default
	#floor.tile_set.get_source(0).texture = load("res://resources/sprites/FightBackgrounds/Sakura/cherry tile.png")
	
	# Warning screen, tells player controls
	#if (ItemStorage.inputtoggle == true):
		#input_screen.visible = true
	#else:
		#input_screen.visible = false
	
# When a key is pressed, perform actions
func _input(event):
	# Start fight
	if !started && event is InputEventKey:
		# input_screen.visible = false
		started = true
		Global.combo = 0
		start.emit()

func _process(delta):
	# Set header values (combo, time, visual timer)
	combo_label.text = "x" + str(enemy.combo)

## Creates a randomly placed Damage text around Enemy on hit
## Shows how much damage Glassy does in hit
##
## Parameters:
## dmgNumber	int: Description of the first parameter.
func _on_enemy_show_dmg(dmgNumber):
	var damage_label = Label.new()		# Create new damage label
	enemy.add_child(damage_label)		# Make label child of Enemy
	damage_label.text = str(dmgNumber)	# Set label value to damage done
	# Set look of damage label
	damage_label.set("theme_override_colors/font_color", Color.DARK_RED)
	damage_label.set("theme_override_font_sizes/font_size", 30)
	# Move damage label randomly around Enemy
	var rand1 = randi_range(0, 50)
	var rand2 = randi_range(0, 30)
	var neg = 1 if randi_range(0, 1) == 0 else -1
	damage_label.position += Vector2(-30 + (rand1 * neg) + rand2, -40 + rand1 + rand2 -10)
	# Remove label after some time
	await get_tree().create_timer(0.2).timeout
	enemy.remove_child(damage_label)
