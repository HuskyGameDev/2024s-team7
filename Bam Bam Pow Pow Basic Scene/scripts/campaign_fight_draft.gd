extends Node

# What we'll need to find a way to handle here:

# Changing backgrounds and enemies
# Calculating health
# Moving to next correct screen

@onready var enemy = $FightBase/enemy
@onready var enemySprite = $FightBase/enemy/Sprite2D
@onready var background = $FightBase/TextureRect
@onready var floor = $FightBase/TileMap

@onready var hpLabel = $HP
@onready var hpBar = $HPbar
@onready var done = false

signal animationStart

@onready var animScene = preload ("res://Scenes/Playable/AnimationPlayer.tscn")



func _ready():
	FightDetails.infinity = false
	
	# Set all opponent values
	enemy.max_health = FightDetails.op_list[FightDetails.op_progress]["health"]
	enemy.current_health = FightDetails.op_list[FightDetails.op_progress]["health"]
	enemySprite.texture = load(FightDetails.op_list[FightDetails.op_progress]["sprite_path"])
	
	# Set all background values
	background.texture = load(FightDetails.op_list[FightDetails.op_progress]["background_path"])
	floor.tile_set.get_source(0).texture = load(FightDetails.op_list[FightDetails.op_progress]["floor_path"])
	
	# Connect
	enemy.health_changed.connect(healthChanged)
	healthChanged()


# Function that runs when enemy takes damage:
# Changes health bar/text on screen; Checks if enemy dies
func healthChanged():
	if (done):
		pass
	hpBar.value = enemy.current_health * 100 / enemy.max_health 
	hpLabel.text = "HP: " + str(enemy.current_health)
	
	if (enemy.current_health <= 0):
		print("they died")
		defeatEnemy()
		# maybe i'll do animation this way, idk. would need to stop fight somehow, 
		# but would allow argument instead of global
		#var animation = animScene.instantiate()
		#add_child(animation)		
		#animationStart.emit("win")
		

# Function that runs when an enemy is defeated:
# Changes the enemy's data to say they've been defeated
# Manages whether this is a new defeat (ergo new weapon)
# Moves to next enemy, Changes scene
func defeatEnemy():
	if (done):
		pass
	done = true
	if (!FightDetails.op_list[FightDetails.op_progress]["defeated"]):
		FightDetails.op_list[FightDetails.op_progress]["defeated"] = true
		FightDetails.newWeaponNotification = true
	FightDetails.animation = "win"
	
	if (FightDetails.op_progress < FightDetails.op_list.size()+1):	
		FightDetails.op_progress = FightDetails.op_progress+1
		print("went to next guy")
		print("fight num: ",FightDetails.op_progress)
		# animation not accessed for 2/20/25 playtest
		#SceneSwap.scene_swap("res://Scenes/Playable/AnimationPlayer.tscn")
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

# Function that runs when timer runs out/you are defeated
# Changes scene
func _on_fight_base_timeout():
	if (enemy.current_health > 0):
		
		# FightDetails.animation = "lose"
		# animation not accessed for 2/20/25 playtest
		#SceneSwap.scene_swap("res://Scenes/Playable/AnimationPlayer.tscn")
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
	
