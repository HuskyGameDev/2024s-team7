extends Control


@export var enemy_poster_rect: TextureRect
@export var fight_button_container: MarginContainer
@onready var curr_index: int = 0


enum ENEMIES {
	GOBLIN,
	BATTY,
	SBJ,
	ROBIT,
	MOON,
	PLOMP,
	BALTIMORE
}


## This function will change the enemy poster to the new index it has been 
## changed to. It will also position the fight button to the correct position.
##
## Parameters:
## void: There are no parameters for this function as it references globals in
## this script.
##
## Returns:
## void: There is no return. 
func change_index(change: int):
	curr_index += change
	if curr_index < 0:
		curr_index = ENEMIES.size() - 1
	if curr_index >= ENEMIES.size():
		curr_index = 0
	match curr_index:
		ENEMIES.GOBLIN:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/gobbo_poster.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		ENEMIES.BATTY:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/batty_poster.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_END
		ENEMIES.SBJ:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/sbj.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		ENEMIES.ROBIT:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/robit.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_END
		ENEMIES.MOON:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/moon_poster.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_END
		ENEMIES.PLOMP:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/plomp_poster.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		ENEMIES.BALTIMORE:
			enemy_poster_rect.texture = preload("res://resources/sprites/FightSelect/baltimore.png")
			fight_button_container.size_flags_horizontal = Control.SIZE_SHRINK_END
	


func _on_up_button_pressed() -> void:
	change_index(1)


func _on_down_button_pressed() -> void:
	change_index(-1)
