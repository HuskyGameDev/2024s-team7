## This scene holds all elements of the Fight backgrounds
##
## In it, you can set the floor tile, still background,
## and instantiate as many ParallaxLayers as you'd like
##
## This scene also holds the functions to change the background

# Note: If you'd like to change the background without script, just edit
# the exported variables in Inspector. Match String exactly if using Background 
# Setup. Background Setup overrides other exported variables.


extends ParallaxBackground

# Node References
@onready var still_background = $TextureRect
@onready var bg_floor = $FloorTiles/TileMapLayer

# Default background values
@export var background_setup_function = "sakura"
@export var still_background_texture = "res://resources/sprites/FightBackgrounds/Sakura/parallax-sky-cherry.png"
@export var floor_tile_texture = "res://resources/sprites/FightBackgrounds/Sakura/cherry tile.png"

@onready var moving_objects = []
@onready var animated_sprites = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if !FightDetails.infinity:
		background_setup_function = FightDetails.op_list[FightDetails.op_progress]["background_setup_function"]
	
	#Run setup function of current background
	match background_setup_function:
		"sakura":
			sakura()
		"cave":
			cave()
		"jonestown":
			jonestown()
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

## Adds a Sprite2D to a ParallaxLayer
##
## Parameters:
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

## Adds an Animated2dSprite to a ParallaxLayer
##
## Parameters:
## layerParent	ParallaxLayer: The parent ParallaxLayer to sprite
##
## Returns:
## AnimatedSprite2D: The AnimatedSprite2D created
func _add_animated_sprite(layerParent: ParallaxLayer) -> AnimatedSprite2D:
	var animatedSprite = AnimatedSprite2D.new()
	layerParent.add_child(animatedSprite)
	var spriteFrames = SpriteFrames.new()
	spriteFrames.add_animation("Animation")
	animatedSprite.sprite_frames = spriteFrames
	
	animatedSprite.centered = false
	animatedSprite.scale.x = 2
	animatedSprite.scale.y = 2
	
	return animatedSprite

## Adds a frame to an AnimatedSprite2D sprite_frames
##
## Parameters:
## animatedSprite	AnimatedSprite2D: The animated sprite that will hold the frames
## texturePath		String: Path to the texture of the frame
## duration			float: How long the frame lasts
## startTime			float: When the frame starts
##
func _add_animated_sprite_frame(animatedSprite: AnimatedSprite2D, texturePath: String, duration: float, startTime: float):
	animatedSprite.sprite_frames.add_frame("Animation", load(texturePath), duration, startTime)

## Adds dictionary to moving_objects array
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

## Adds background for dungeon (goblin)
func cave():
	var torchBackgroundLayer = _add_layer(.5)
	var animatedTorchBGSprite = _add_animated_sprite(torchBackgroundLayer)
	var torchFrame0 = _add_animated_sprite_frame(animatedTorchBGSprite, "res://resources/sprites/FightBackgrounds/Cave/bg1.png", 2, 0)
	var torchFrame1 = _add_animated_sprite_frame(animatedTorchBGSprite, "res://resources/sprites/FightBackgrounds/Cave/bg2.png", 2, 2)
	animatedTorchBGSprite.play( "Animation")
	
	var caveLayer1 = _add_layer(.7)
	var caveSprite1 = _add_sprite(caveLayer1, "res://resources/sprites/FightBackgrounds/Cave/1.png")
	
	var caveLayer2 = _add_layer(.9)
	var caveSprite2 = _add_sprite(caveLayer2, "res://resources/sprites/FightBackgrounds/Cave/2.png")
	
## Adds background for Jonestown (sweet baby jones)
func jonestown():
	still_background_texture = "res://resources/sprites/FightBackgrounds/Jonestown/Sky.png"
	bg_floor.visible = false
	
	var sunLayer = _add_layer(0)
	var sunSprite = _add_sprite(sunLayer, "res://resources/sprites/FightBackgrounds/Jonestown/Sun.png")
	
	var farCloudLayer = _add_layer(0)
	var farCloudSprite = _add_sprite(farCloudLayer, "res://resources/sprites/FightBackgrounds/Jonestown/Cloud2.png")
	_make_moving_objects_dict(farCloudLayer, -5, 0)
	
	var closeCloudLayer = _add_layer(0)
	var closeCloudSprite = _add_sprite(closeCloudLayer, "res://resources/sprites/FightBackgrounds/Jonestown/Cloud1.png")
	_make_moving_objects_dict(closeCloudLayer, -12, 0)
	
	var farHillsLayer = _add_layer(.3)
	var farHillsSprite = _add_sprite(farHillsLayer, "res://resources/sprites/FightBackgrounds/Jonestown/FarHills.png")
	
	var midHillsLayer = _add_layer(.5)
	var midHillsSprite = _add_sprite(midHillsLayer, "res://resources/sprites/FightBackgrounds/Jonestown/MidHills.png")
	
	var closeHillsLayer = _add_layer(1)
	var closeHillsSprite = _add_sprite(closeHillsLayer, "res://resources/sprites/FightBackgrounds/Jonestown/CloseHills.png")

func moon():
	still_background_texture = "res://resources/sprites/FightBackgrounds/Moon/bg.png"
	bg_floor.visible = false
	var twinkleLayer = _add_layer(0)
	var twinkleAnimation = _add_animated_sprite(twinkleLayer)
	var twinkleFrame0 = _add_animated_sprite_frame(twinkleAnimation, "res://resources/sprites/FightBackgrounds/Moon/stars1.png", 2, 0)
	var twinkleFrame1 = _add_animated_sprite_frame(twinkleAnimation, "res://resources/sprites/FightBackgrounds/Moon/stars2.png", 2, 2)
	twinkleAnimation.play( "Animation")
	
	var farHillsLayer = _add_layer(.4)
	var farHillsSprite = _add_sprite(farHillsLayer, "res://resources/sprites/FightBackgrounds/Moon/far-hill.png")
	
	var closeHillsLayer = _add_layer(1)
	var closeHillsSprite = _add_sprite(closeHillsLayer, "res://resources/sprites/FightBackgrounds/Moon/close-hill.png")

## Doesn't add background atm
func dog():
	pass
	
	

	
