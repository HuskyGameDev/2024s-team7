extends TextureProgressBar

@export var enemy: Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy.health_changed.connect(update)
	update()

func update():
	value = enemy.current_health *100 / enemy.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
