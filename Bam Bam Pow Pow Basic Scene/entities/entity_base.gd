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
var dmg = []

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")
	dmg.resize(20)
	readyDamage()

# Alters the damageMult and moneyMult variables depending on items the player has bought from the shop
func readyDamage():
	for i in range (20):
		if (ItemStorage.itemsList[i].owned == true):
			dmg[i] = 1.0
		else:
			dmg[i] = -1.0
	for i in range(20,99):
		if (ItemStorage.itemsList[i].owned == true):
			if(ItemStorage.itemsList[i].type == ItemStorage.MULTTYPE.MONEY):
				moneyMult += ItemStorage.itemsList[i].multiplier
			elif(ItemStorage.itemsList[i].type == ItemStorage.MULTTYPE.BASE):
				for j in range (4):
					dmg[j] += ItemStorage.itemsList[i].multiplier
					j = j + 5
			elif(ItemStorage.itemsList[i].type == ItemStorage.MULTTYPE.LITERAL):
				if(dmg[ItemStorage.itemsList[i].index] != -1):
					dmg[ItemStorage.itemsList[i].index] += ItemStorage.itemsList[i].multiplier
			else:
				var trueInd = ItemStorage.itemsList[i].index
				for j in range (0,4):
					if (dmg[trueInd] != -1):
						dmg[trueInd] += ItemStorage.itemsList[i].multiplier
					trueInd = trueInd + 5
	for i in range(20):
		if (i % 5 != 0 && dmg[i] != -1):
				var j = i-(i % 5)
				dmg[i] = dmg[j] * dmg[i]
	print(dmg)

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
