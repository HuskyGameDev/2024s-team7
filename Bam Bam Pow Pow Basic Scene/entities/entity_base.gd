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
var damageMult = 1.0
var punchMult = 1.0
var kickMult = 1.0
var weapMult = 1.0
var specMult = 1.0
var upMult = 1.0
var downMult = 1.0
var leftMult = 1.0
var rightMult = 1.0

var moneyMult = 1.0 # Multiplier for money stats
var itemsOwned = [20]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")
	readyMults()

# Alters the damageMult and moneyMult variables depending on items the player has bought from the shop
func readyMults():
	for i in range(11):
		if(ItemStorage.itemsList[i].owned == true):
			moneyMult = moneyMult * ItemStorage.itemsList[i].multiplier
	for i in range(11,21):
		if(ItemStorage.itemsList[i].owned == true):
			base_damage = base_damage * ItemStorage.itemsList[i].multiplier
	for i in range (21,41):
		itemsOwned[i-21] = -1
		var dam = base_damage * damageMult
		if (i < 26):
			dam = dam * punchMult
		elif (i >= 26 && i < 31):
			dam = dam * kickMult
		elif (i >= 31 && i < 36):
			dam = dam * weapMult
		else:
			dam = dam * specMult
		if (i % 5 == 2):
			dam = dam * upMult
		elif (i % 4 == 3):
			dam = dam * downMult
		elif (i % 4 == 4):
			dam = dam * leftMult
		elif (i % 4 == 0):
			dam = dam * rightMult
		if (ItemStorage.itemsList[i].owned == true):
			itemsOwned[i-21] = dam

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

	if self.score >= 2000 && !addedMoney:
		addedMoney = true
		ItemStorage.money += (score * moneyMult)
		SceneSwap.scene_swap("res://Scenes/ItemShop.tscn")
