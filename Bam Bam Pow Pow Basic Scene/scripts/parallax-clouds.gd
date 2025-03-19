extends ParallaxBackground

@onready var far = $ParallaxLayer2
@onready var mid = $ParallaxLayer3
@onready var close = $ParallaxLayer4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	far.motion_offset.x += -4 * delta
	mid.motion_offset.x += -8 * delta
	close.motion_offset.x += -12 * delta
