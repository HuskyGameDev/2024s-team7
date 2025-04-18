extends Control

@export var textures: Array[Texture2D] = [preload("res://resources/sprites/rhe_square.png")]
@export var frame_speed: float = 1.0
@onready var credits: TextureRect = $animatedCreditsTextureRect
@onready var time_elapsed: float = 0
@onready var len_textures: int = 1
@onready var cur_index: int = 0
@onready var real_speed: float = 0


## This function initializes some values for use when the node is active.
func _ready() -> void:
	credits.texture = textures[0]
	len_textures = len(textures) - 1
	real_speed = 1.0 / frame_speed


## This is a default godot function. This implementation of it uses the delta
## value to control the speed in which the different frames of an animation play.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > real_speed:
		time_elapsed = 0
		cur_index += 1
		if cur_index > len_textures:
			cur_index = 0
		credits.texture = textures[cur_index]


## This function handles the action of going back to the main menu when the exit
## button is pressed.
func _on_exit_button_pressed() -> void:
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn")


## This function handles the action of opening the github page for the game when
## the credits button is pressed.
func _on_github_button_pressed() -> void:
	OS.shell_open("https://github.com/HuskyGameDev/2024s-team7")
