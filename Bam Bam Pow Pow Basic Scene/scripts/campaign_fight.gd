## This scene handles all changes to FightBase specific to the Campaign
##
## Campaign has different opponents that need to be defeated within
## the time limit. Otherwise, the player is shattered by the opponent
## and needs to recover and try again.
##
## Included is: Health Management (Bar, HP text, Damage -> HP),
## Setting opponent specific values (Enemy Sprites, Floor, Background),
##
## TODO:
## Dialogic interaction with enemies (Issue #28)
## Some special event on fight end (win, lose)

extends Node
signal timeline_ended
## Node references
@onready var enemy = $FightBase/enemy
@onready var enemySprite = $FightBase/enemy/Sprite2D
@onready var background = $FightBase/ParallaxElements
@onready var hpLabel = $CanvasLayer/HP
@onready var hpBar = $CanvasLayer/HPbar
@onready var timer = $Timer
@onready var timeLabel = $CanvasLayer/TimeLabel
@onready var timerSprite = $CanvasLayer/TimerSprite
@onready var audio_timer: AudioStreamPlayer = $AudioTimer
@onready var canvas_layer = $CanvasLayer
@onready var enemy_animation_player = $FightBase/enemy/AnimationPlayer
@onready var player_FSM = $FightBase/player/FSM

@onready var currentEnemy = FightDetails.op_list[FightDetails.op_progress]
@onready var currentEnemyIndex = FightDetails.op_progress

@onready var done = false
@onready var fiveSecond_noise = preload("res://resources/sounds/fiveseconds.wav")
var results = preload("res://Scenes/Playable/ResultsScreen.tscn").instantiate()

func _ready():
	#Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	FightDetails.shatter.connect(on_shatter)
	# Set fight type to Campaign
	# Put here as well mainly for testing. Is set when Campaign/Infinity is in-game
	FightDetails.infinity = false
	set_enemy_values(currentEnemy["health"], currentEnemy["sprite_path"])
	# Connect 'health_changed' from enemy scene to local 'healthChanged' function
	enemy.hit.connect(healthChanged)
	healthChanged()
	
	if currentEnemy["first_try"]:
		Dialogic.VAR.FirstFight = true
		currentEnemy["first_try"] = false
	else:
		Dialogic.VAR.FirstFight = false
	
	_start_dialog("Startup")

func _process(delta):
	# Set timer label values
	timeLabel.text = "Time: " + "%.3f" % timer.time_left
	timerSprite.value = (100/timer.wait_time)*(timer.wait_time-timer.time_left)
	# If time is low, start low timer sounds
	if timer.time_left < 5 && timer.time_left > 4 && (!audio_timer.is_playing()):
			audio_timer.stream = fiveSecond_noise
			audio_timer.play()

func set_enemy_values(opponent_health: int, opponent_sprite_path: String):
	enemy.max_health = opponent_health
	enemy.current_health = opponent_health
	enemySprite.texture = load(opponent_sprite_path)

## Function that runs when enemy takes damage:
## Changes health bar/text on screen; Checks if enemy dies
func healthChanged():
	# Check if enemy's already been 'defeated' this fight
	if (done):
		return
	
	# Change health values on screen to reflect new damage
	hpBar.value = enemy.current_health * 100 / enemy.max_health 
	hpLabel.text = "HP: " + str(enemy.current_health)
	
	# End fight if enemy HP runs out
	if (enemy.current_health <= 0):
		done = true
		print("they died")
		defeatEnemy()

## Function that runs when an enemy's health reaches 0:
## Changes the enemy's data to say they've been defeated,
## Manages whether this is a new defeat (ergo new weapon),
## Moves to next enemy, Changes scene
func defeatEnemy():
	if Dialogic.Text.is_textbox_visible():
		await timeline_ended
	# Change all necessary values given fight ended
	done = true
	FightDetails.win = true
	enemy.calc_money()
	#TODO: make this time taken instead of time left
	# Not done yet bc I need to actually set the max time to the one in the enemy dict
	# Problem: idk how the adding to the timer works. will need to make sure no conflicts.
	Global.time_left = timer.time_left
	
	# # Set the global value of whether opponent has ever been defeated
	if (!currentEnemy["defeated"]):
		currentEnemy["defeated"] = true
		#FightDetails.newWeaponNotification = true
	
	# Set current enemy to the next in list
	#
	# Check if reached end of enemies
	if (currentEnemyIndex < FightDetails.op_list.size() - 1):	
		FightDetails.op_progress = currentEnemyIndex + 1
		print("went to next guy")
		print("fight num: ",FightDetails.op_progress)
	_start_dialog("GlassyWins")
	await timeline_ended
	get_tree().paused = true
	await get_tree().create_timer(.5).timeout
	canvas_layer.add_child(results)

	#SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn")

## Function that runs when timer runs out
## Changes scene
func _on_timer_timeout():
	enemy.calc_money()
	if (enemy.current_health > 0):
		FightDetails.win = false
		_start_dialog("GlassyLoses")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		await timeline_ended
		await get_tree().create_timer(.5).timeout
		canvas_layer.add_child(results)
		get_tree().paused = true

# Start timer when Fight Base starts fight
func _on_fight_base_start():
	await get_tree().create_timer(.3).timeout
	timer.wait_time = ItemStorage.time
	timer.start()
	_start_dialog("FirstHit")

func _start_dialog(label_name):
	Dialogic.start(currentEnemy["opName"], label_name).process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
		
func _on_timeline_ended():
	get_tree().paused = false
	timeline_ended.emit()

# Does not exist yet.
# I deleted Shattered node (child of FSM) because I couldn't figure out how to get it to work.
func on_shatter():
	player_FSM.force_change_state("Shattered")
