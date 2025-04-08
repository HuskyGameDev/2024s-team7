## This scene is a child of all Fight sequences.
## It holds the player, enemy, background, timer, and combo counter.
## This scene is nearly identical to our previous 'Fight' scene',

extends Node

signal start

# Variables
var started = false
# Node References
@onready var enemy = $enemy
@onready var player = $player
@onready var combo_label = $CanvasLayer/combo
@onready var musicplayer: AudioStreamPlayer = $MusicPlayer
const Song = preload("res://resources/sounds/FightSongDraft.wav")

func _ready():
	combo_label.text = "x0"


# When a key is pressed, perform actions
func _input(event):
	pass
	## Start fight
	#if !started && event is InputEventKey:
		#started = true
		#Global.combo = 0
		#start.emit()
		#musicplayer.stream = Song
		#if (musicplayer.volume_db > -10):
			#musicplayer.volume_db = musicplayer.volume_db - 10
		#musicplayer.play()

func _process(delta):
	pass

## Creates a randomly placed Damage text around Enemy on hit
## Shows how much damage Glassy does in hit
##
## Parameters:
## dmgNumber	int: Description of the first parameter.
func _on_enemy_show_dmg(dmgNumber):
	# Add new damage label as enemy's child
	var damage_label = Label.new()
	enemy.add_child(damage_label)
	damage_label.text = str(dmgNumber)
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

# Change header values when Enemy hit
func _on_enemy_hit():
	# Start fight
	if !started:
		started = true
		Global.combo = 0
		start.emit()
		musicplayer.stream = Song
		if (musicplayer.volume_db > -10):
			musicplayer.volume_db = musicplayer.volume_db - 10
		musicplayer.play()
	combo_label.text = "x" + str(enemy.combo)
