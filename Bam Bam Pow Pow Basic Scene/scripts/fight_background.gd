## This scene holds all elements of the Fight backgrounds
##
## In it, you can set the floor tile, still background,
## and instantiate as many ParallaxLayers as you'd like
##
## This scene also holds the functions to change the background

# Note: If you'd like to change the background without script, just edit
# the exported variables. Match String exactly if using Background Setup.
# Background Setup overrides other exported variables.


extends ParallaxBackground

# Node References
@onready var still_background = $TextureRect
@onready var bg_floor = $FloorTiles/TileMapLayer

# Exported variables, available to change in Inspector
@export var background_setup_function = "sakura"
@export var still_background_texture = "res://resources/sprites/FightBackgrounds/Sakura/parallax-sky-cherry.png"
@export var floor_tile_texture = "res://resources/sprites/FightBackgrounds/Sakura/cherry tile.png"

@onready var moving_objects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Run setup function of current background
	match background_setup_function:
		"sakura":
			sakura()
		"sweetBabyJones":
			sweetBabyJones()
		"dog":
			dog()
	# Set still background and floor
	still_background.texture = load(still_background_texture)
	bg_floor.tile_set.get_source(0).texture = load(floor_tile_texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!moving_objects.is_empty()):
		_move(delta)

## Add a new Parallax Layer into the Fight Background
##
## Parameters:
## layerscale	float: The higher the scale, the faster it moves across the screen
##
## Returns:
## ParallaxLayer: The Parallax Layer created
func _add_layer(layerScale: float) -> ParallaxLayer:
	var layerParent = ParallaxLayer.new()
	add_child(layerParent)
	layerParent.motion_scale.x = layerScale
	layerParent.motion_scale.y = layerScale
	# Default background layer settings
	layerParent.motion_mirroring.x = 1400
	
	return layerParent

## Adds a sprite to a ParallaxLayer
##
## Parameters:
##
## layerParent	ParallaxLayer: The parent ParallaxLayer to sprite
## spritePath	String: Path to sprite's texture
##
## Returns:
## Sprite2D: The sprite created
func _add_sprite(layerParent: ParallaxLayer, spritePath: String) -> Sprite2D:
	var layerSprite = Sprite2D.new()
	layerParent.add_child(layerSprite)
	layerSprite.texture = load(spritePath)
	# Default background sprite settings
	layerSprite.centered = false
	layerSprite.scale.x = 2
	layerSprite.scale.y = 2

	return layerSprite

## Adds dictionary to movingObjects array
##
## Parameters:
## movingObject		ParallaxLayer: The layer that will be in motion 
## xMovingSpeed		int: Speed at which layer moves in X (pixels/frame)
## yMovingSpeed		int: Speed at which layer moves in Y (pixels/frame)
##
func _make_moving_objects_dict(movingObject: ParallaxLayer, xMovingSpeed: int, yMovingSpeed: int):
	var moving_object_details : Dictionary = {
		"movingObject":	movingObject,
		"xMovingSpeed":	xMovingSpeed,
		"yMovingSpeed":	yMovingSpeed
	}
	moving_objects.append(moving_object_details)

## Moves all 'moving' layers; Called by _process
##
## 'Moving' layers have additional motion regardless of Glassy, which 
## process every frame. They move at a speed of (pixels/frame)
##
## Parameters:
## delta: frame
##
func _move(delta):
	for i in range(moving_objects.size()):
		if (moving_objects[i]["xMovingSpeed"] != 0):
			moving_objects[i]["movingObject"].motion_offset.x += moving_objects[i]["xMovingSpeed"] * delta
		if (moving_objects[i]["yMovingSpeed"] != 0):
			moving_objects[i]["movingObject"].motion_offset.y += moving_objects[i]["yMovingSpeed"] * delta
		pass

## Adds all frames necessary for Sakura background
func sakura():
	# Set still background and floor
	still_background_texture = "res://resources/sprites/FightBackgrounds/Sakura/parallax-sky-cherry.png"
	floor_tile_texture = "res://resources/sprites/FightBackgrounds/Sakura/cherry tile.png"
	
	## Create all layers:
	
	# Cloud Layers:
	#
	# Create and fill first layer:
	var farCloudsLayer = _add_layer(0)
	var farCloudsSprite = _add_sprite(farCloudsLayer, "res://resources/sprites/FightBackgrounds/Sakura/far clouds.png")
	# Add movement to layer
	_make_moving_objects_dict(farCloudsLayer, -4, 0)
	#
	# Create and fill second layer:
	var midCloudsLayer = _add_layer(0)
	var midCloudsSprite = _add_sprite(midCloudsLayer, "res://resources/sprites/FightBackgrounds/Sakura/mid clouds.png")
	# Add movement to layer
	_make_moving_objects_dict(midCloudsLayer, -8, 0)
	#
	# Create and fill third layer:
	var closeCloudsLayer = _add_layer(0)
	var closeCloudsSprite = _add_sprite(closeCloudsLayer, "res://resources/sprites/FightBackgrounds/Sakura/close clouds.png")
	# Add movement to layer
	_make_moving_objects_dict(closeCloudsLayer, -12, 0)
	
	# Tree Layers:
	#
	# Create and fill third layer:
	var midTreesLayer = _add_layer(.3)
	var midTreesSprite = _add_sprite(midTreesLayer, "res://resources/sprites/FightBackgrounds/Sakura/midtrees.png")
	#
	# Create and fill third layer:
	var closeTreesLayer = _add_layer(.6)
	var closeTreesSprite = _add_sprite(closeTreesLayer, "res://resources/sprites/FightBackgrounds/Sakura/foretree.png")

func sweetBabyJones():
	pass

func dog():
	pass

	
