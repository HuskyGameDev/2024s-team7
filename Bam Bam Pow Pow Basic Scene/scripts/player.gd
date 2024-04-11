extends CharacterBody2D

@export var score: int = 0

@onready var animTree : AnimationTree = $AnimationTree

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animTree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed('J')  and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed('P') and is_on_floor():
		animTree["parameters/conditions/punch"] = true
		
	if Input.is_action_just_pressed('K') and is_on_floor():
		animTree["parameters/conditions/kick"] = true
		
	if Input.is_action_just_pressed('W') and is_on_floor():
		animTree["parameters/conditions/weapon"] = true
		
		
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hurtbox_area_entered(hitbox):
	var damage = hitbox.motion
	self.score += damage 
	print("Total DMG = " + str(score))
