extends CharacterBody2D

@export var hp: int = 1
@export var weight: int = 100
@export var score: int = 0
@export var base_damage: int = 10
@export var juggle: int = 0

@onready var sprite = $Sprite2D
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer
@onready var animTree : AnimationTree = $AnimationTree

var addedMoney = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * weight/100
	if is_on_floor():
		self.juggle = 0

	move_and_slide()


func _on_hurtbox_area_entered(hitbox):
	self.juggle += 1
	var damage = (self.base_damage * hitbox.motion) * self.juggle
	self.score += damage
	animPlayer.play("hurt")
	velocity.y -= 100*hitbox.weight
	print(hitbox.get_parent().name + "'s hitbox touched " + name)
	print(str(damage) + " dealt!")
	print("Juggle Count: " + str(self.juggle))

	if self.score >= 20000 && !addedMoney:
		addedMoney = true
		ItemStorage.money += score
		SceneSwap.scene_swap("res://Scenes/ItemShop.tscn")
