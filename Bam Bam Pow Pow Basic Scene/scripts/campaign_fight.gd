## This scene handles all changes to FightBase specific to the Campaign
##
## Campaign has different opponents that need to be defeated within
## the time limit. Otherwise, the player is shattered by the opponent
## and needs to recover and try again.
##
## Included is: Health Management (Bar, HP text, Damage -> HP),
## Setting opponent specific values (Enemy Sprites, Floor, Background),
##
## What needs to be added:
## Dialogic interaction with enemies (Issue #28)
## Some special event on fight end (win, lose)
## On loss lose coins as hospital bill

extends Node

# signal animationStart

## Variables
@onready var done = false
@onready var fiveSecond_noise = preload("res://resources/sounds/fiveseconds.wav")
## Node references
@onready var enemy = $FightBase/enemy
@onready var enemySprite = $FightBase/enemy/Sprite2D
@onready var background = $FightBase/TextureRect
@onready var floor = $FightBase/TileMap
@onready var hpLabel = $HP
@onready var hpBar = $HPbar
@onready var timer = $Timer
@onready var timeLabel = $TimeLabel
@onready var timerSprite = $TimerSprite
@onready var audio_timer: AudioStreamPlayer = $AudioTimer


func _ready():
	# Set fight type to Campaign
	FightDetails.infinity = false

	# Set all opponent values
	enemy.max_health = FightDetails.op_list[FightDetails.op_progress]["health"]
	enemy.current_health = FightDetails.op_list[FightDetails.op_progress]["health"]
	enemySprite.texture = load(FightDetails.op_list[FightDetails.op_progress]["sprite_path"])
	
	# Set all background values
	background.texture = load(FightDetails.op_list[FightDetails.op_progress]["background_path"])
	floor.tile_set.get_source(0).texture = load(FightDetails.op_list[FightDetails.op_progress]["floor_path"])
	
	# Connect 'health_changed' from enemy scene to local 'healthChanged' function
	enemy.health_changed.connect(healthChanged)
	healthChanged()

func _process(delta):
	# Set timer label values
	timeLabel.text = "Time: " + "%.3f" % timer.time_left
	timerSprite.value = (100/timer.wait_time)*(timer.wait_time-timer.time_left)
	# If time is low, start low timer sounds
	if timer.time_left < 5 && timer.time_left > 4 && (!audio_timer.is_playing()):
			audio_timer.stream = fiveSecond_noise
			audio_timer.play()
	print(timer.wait_time)

## Function that runs when enemy takes damage:
## Changes health bar/text on screen; Checks if enemy dies
func healthChanged():
	# Check if enemy's already been 'defeated' this fight
	if (done):
		pass
	
	# Change health values on screen to reflect new damage
	hpBar.value = enemy.current_health * 100 / enemy.max_health 
	hpLabel.text = "HP: " + str(enemy.current_health)
	
	# End fight if enemy HP runs out
	if (enemy.current_health <= 0):
		done = true
		print("they died")
		defeatEnemy()
		# maybe i'll do animation this way, idk. would need to stop fight somehow, 
		# but would allow argument instead of global
		#var animation = animScene.instantiate()
		#add_child(animation)		
		#animationStart.emit("win")
		

## Function that runs when an enemy is defeated:
## Changes the enemy's data to say they've been defeated,
## Manages whether this is a new defeat (ergo new weapon),
## Moves to next enemy, Changes scene
func defeatEnemy():
	# Check if enemy has already been 'defeated' this fight
	if (done):
		pass
	
	# Set this fight sequence completed
	done = true
	
	# Set the global value of whether opponent has ever been defeated
	#
	# Check if already been defeated
	if (!FightDetails.op_list[FightDetails.op_progress]["defeated"]):
		# If not, set has been
		FightDetails.op_list[FightDetails.op_progress]["defeated"] = true
		#FightDetails.newWeaponNotification = true
	#FightDetails.animation = "win"
	
	# Set current enemy to the next in list
	#
	# Check if reached end of enemies
	if (FightDetails.op_progress < FightDetails.op_list.size()+1):	
		FightDetails.op_progress = FightDetails.op_progress+1
		print("went to next guy")
		print("fight num: ",FightDetails.op_progress)
		
		# animation not accessed for 2/20/25 playtest
		#SceneSwap.scene_swap("res://Scenes/Playable/AnimationPlayer.tscn")
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
	# If reached end, leave Campaign
	else:
		SceneSwap.scene_swap("res://Scenes/Playable/FightSelect.tscn")

## Function that runs when timer runs out
## Changes scene
func _on_timer_timeout():
	enemy.calc_money()
	if (enemy.current_health > 0):
		# FightDetails.animation = "lose"
		# animation not accessed for 2/20/25 playtest
		#SceneSwap.scene_swap("res://Scenes/Playable/AnimationPlayer.tscn")
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

# Start timer when Fight Base starts fight
func _on_fight_base_start():
	timer.start()

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
