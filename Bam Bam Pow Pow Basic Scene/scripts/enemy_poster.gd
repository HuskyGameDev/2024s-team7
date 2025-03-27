## This is the scene which will display all the information about a specific
## enemy. All of the configuration of that poster is provided via a JSON file.

extends Control

## This is the name of the enemy to load. This has to match the name of the JSON
## file associated with this enemy.
@export var enemy_to_load: String="example"

## This is the container fo the enemy vbox.
@export var enemy_vbox_container: VBoxContainer

## This is the enemy name node.
@export var enemy_name_label: Label

## This is the **container** holding the enemy picture on the poster.
@export var enemy_picture_container: MarginContainer

## This is the enemy picture node.
@export var enemy_picture: TextureRect

## This is the enemy description node.
@export var enemy_description_label: Label
	

## This is the ready function for the enemy poster. This will setup all of the
## variables for the enemy and make the poster look as directed by the JSON.
##
## Parameters:
## None
##
## Returns:
## void: This is a ready function with no return.
func _ready() -> void:
	var path = "res://resources/enemies/" + enemy_to_load + ".json"
	var enemy = get_json(path)
	set_enemy_name(enemy.name)
	set_picture(enemy.picture_path)
	set_picture_location(enemy.picture_location)
	set_picture_margins(enemy.picture_margins)
	set_enemy_description(enemy.description)
	

## Check to see if the JSON file exists, if so then retrieve its data.
##
## Parameters:
## String	path: The path to the JSON file.
##
## Returns:
## Dictionary: This is the data for the self.
func get_json(path: String) -> Dictionary:
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if data is Dictionary:
			return data
		else:
			printerr("Error reading from file.")
			return {}
	else:
		printerr("Enemy file does not exist.")
		return {}


## This function will set the name of the enemy on the poster.
##
## Parameters:
## String	enemy_name: The name of the enemy. Defaults to "No Name" if no name
## is given.
## 
## Returns:
## void: This is a setter with no return.
func set_enemy_name(enemy_name: String="No Name") -> void:
	enemy_name_label.text = enemy_name


## This function will set the picture for the enemy poster.
##
## Parameters:
## String	picture_path: The path to the picture for the enemy. Defaults to a
## debug sprite if no path is specified.
##
## Returns:
## void: This is a setter with no return.
func set_picture(picture_path: String="res://resources/sprites/rhe_square.png") -> void:
	enemy_picture.texture = load(picture_path)


## This function will set the picture location for the enemy's poster.
##
## Parameters:
## Location		location: The desired location. See `Location` enum comment for
## specifics on this type.
##
## Returns:
## void: This is a setter with no return.
func set_picture_location(location: String="TOP_LEFT") -> void:
	match location:
		"TOP_LEFT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		"TOP_CENTER":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		"TOP_RIGHT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_BEGIN
		"CENTER_LEFT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		"CENTER_CENTER":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		"CENTER_RIGHT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_CENTER
		"BOTTOM_LEFT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_BEGIN
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical		+= Control.SIZE_EXPAND
			enemy_vbox_container.move_child(enemy_description_label, 1)
		"BOTTOM_CENTER":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_CENTER
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical		+= Control.SIZE_EXPAND
			enemy_vbox_container.move_child(enemy_description_label, 1)
		"BOTTOM_RIGHT":
			enemy_picture_container.size_flags_horizontal 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical 	= Control.SIZE_SHRINK_END
			enemy_picture_container.size_flags_vertical		+= Control.SIZE_EXPAND
			enemy_vbox_container.move_child(enemy_description_label, 1)


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
## Array[int]	margins: This is the array of margins for the picture. The order
## of margins is as follows: left, top, right, bottom.
##
## Returns:
## void: This is a setter with no return.
func set_picture_margins(margins: Array) -> void:
	enemy_picture_container.add_theme_constant_override("margin_left", margins[0])
	enemy_picture_container.add_theme_constant_override("margin_top", margins[1])
	enemy_picture_container.add_theme_constant_override("margin_right", margins[2])
	enemy_picture_container.add_theme_constant_override("margin_bottom", margins[3])
	

## This function will set the enemy description to the desired description.
## 
## Paramteres:
## String	description: This is the description for the enemy on the poster.
## This value defaults to "No description" if nothing is passed to it.
## 
## Returns:
## void: This is a setter with no return.
func set_enemy_description(description: String="No description") -> void:
	enemy_description_label.text = description
