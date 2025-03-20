## This is the scene which will display all the information about a specific
## enemy. All of the configuration of that poster will be called through this 
## script.

extends Control

## This is the **container** holding the enemy picture on the poster. The name
## is as such to simplify the code here.
@export var enemy_picture: MarginContainer


## This enum simplifies the adjustment to the size flags needed to move the
## picture to the desired location.
enum Location {
	TOP_LEFT,
	TOP_CENTER,
	TOP_RIGHT,
	CENTER_LEFT,
	CENTER_CENTER,
	CENTER_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_CENTER,
	BOTTOM_RIGHT
}


## This is a temporary ready function to test out the values. This will be
## replaced with a proper function to initialize based on some values.
func _ready() -> void:
	set_picture_location(Location.BOTTOM_RIGHT)
	set_picture_margins(0, 0, 200, 20)


## This function will set the picture location for the enemy's poster.
##
## Parameters:
## Location		location: The desired location. See `Location` enum comment for
## specifics on this type.
##
## Returns:
## void: This is a setter with no return.
func set_picture_location(location: Location) -> void:
	match location:
		Location.TOP_LEFT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		Location.TOP_CENTER:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		Location.TOP_RIGHT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		Location.CENTER_LEFT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		Location.CENTER_CENTER:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		Location.CENTER_RIGHT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		Location.BOTTOM_LEFT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_END
		Location.BOTTOM_CENTER:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_END
		Location.BOTTOM_RIGHT:
			enemy_picture.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture.size_flags_vertical 	= Control.SIZE_SHRINK_END


## This function will set the picture margins for the enemy's poster. This
## allows for much more fexibility on the picture's position. One use case may
## be to fine tune a sprite to fit the expected location on the background.
##
## NOTE: These margins are meant to be positive integers only! The
## representation of these values is as a positive spacer on the given side of
## the image. So 20 as the `right` value will insert a spacer with a width of 20
## on the right side of the image moving it to the left.
##
## Parameters:
## int	left	: The left margin for the picture.
## int	top		: The top margin for the picture.
## int	right	: The right margin for the picture.
## int	bottom	: The bottom margin for the picture.
##
## Returns:
## void: This is a setter with no return.
func set_picture_margins(left: int, top: int, right: int, bottom: int) -> void:
	enemy_picture.add_theme_constant_override("margin_left", left)
	enemy_picture.add_theme_constant_override("margin_top", top)
	enemy_picture.add_theme_constant_override("margin_right", right)
	enemy_picture.add_theme_constant_override("margin_bottom", bottom)
