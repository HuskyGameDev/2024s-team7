extends Node

# Make cute little animation of sleepy guy
# Move to next screen after like 3 seconds

@onready var time = $Timer
@onready var loadProgress = $MarginContainer/ProgressBar
@onready var timeScale = Engine.time_scale
@onready var animated_sprite = $MarginContainer/AnimatedSprite2D

func _ready():
	Engine.time_scale = timeScale/300
	animated_sprite.play()

func _process(delta):
	print(time.time_left)

	loadProgress.value = time.wait_time - time.time_left
	Engine.time_scale = Engine.time_scale+.09

func _on_timer_timeout():
	print("timeout")
	Engine.time_scale = timeScale
	SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")
