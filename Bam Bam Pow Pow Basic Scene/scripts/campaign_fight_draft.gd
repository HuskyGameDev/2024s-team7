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


signal animationStart(scenario: int)
@onready var animScene: PackedScene = preload ("res://Scenes/Playable/WeaponUnlock.tscn")



func _ready():
	FightDetails.op_progress = 2
	
	# Set all opponent values
	enemy.max_health = FightDetails.op_list[FightDetails.op_progress]["health"]
	enemySprite.texture = load(FightDetails.op_list[FightDetails.op_progress]["sprite_path"])
	
	# Set all background values
	background.texture = load(FightDetails.op_list[FightDetails.op_progress]["background_path"])
	floor.tile_set.get_source(0).texture = load(FightDetails.op_list[FightDetails.op_progress]["floor_path"])
	
	enemy.health_changed.connect(update)
	update()

func update():
	hpBar.value = enemy.current_health * 100 / enemy.max_health 
	hpLabel.text = "HP: " + str(enemy.current_health)
	
	if (enemy.current_health <= 0):
		var animation = animScene.instantiate()
		if (!FightDetails.op_list[FightDetails.op_progress]["defeated"]):
			FightDetails.op_list[FightDetails.op_progress]["defeated"] = true
			animationStart.connect(animation._onready, 1)


func _on_fight_base_timeout():
	if (enemy.current_health > 0):
		var animation = animScene.instantiate()
		animationStart.connect(animation._onready, 0)
	
		

	#if(FightDetails.infinity):
		#SceneSwap.scene_swap("res://Scenes/Playable/InfinityFightDraft.tscn")
	#else:
		#var animation = animScene.instantiate()
		#
#
#
	## If enemy isn't defeated, go to recovery. Won't impact infinity
	##if(Global.score < FightDetails.op_list[FightDetails.op_progress]["health"]):
		##SceneSwap.scene_swap("res://Scenes/Playable/recovery_screen.tscn")
	##else:
		##if(!FightDetails.op_list[FightDetails.op_progress]["defeated"]):
			##FightDetails.op_list[FightDetails.op.progress]["defeated"] = true
			##SceneSwap.scene_swap("res://Scenes/Playable/WeaponUnlock.tscn")
		##else:
			##SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
