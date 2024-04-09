extends CharacterBody2D

@export var hp: int = 1
@export var weight: int = 100
@export var score: int = 0
@export var base_damage: int = 10
@export var juggle: int = 0

@onready var sprite = $Sprite2D
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer

var addedMoney = false

@onready var items = ItemStorage.itemsList
var money_mult = 1.0 # Multiplier for money stats
var mults = []
var damage = []

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")
	mults.resize(20)
	damage.resize(20)
	ready_mults()

# Alters the damageMult and money_mult variables depending on items the player has bought from the shop
func ready_mults():
	# Fill with zeros, initalize base attacks as valid.
	mults.fill(0)
	mults[0] 	= 1
	mults[5] 	= 1
	mults[10] 	= 1
	mults[15] 	= 1
	
	for item in ItemStorage.moneyItems:
		if item["owned"]:
			money_mult += item["mult"]
	
	for item in ItemStorage.baseItems:
		if item["owned"]:
			base_mult(item["mult"])
	
	for item in ItemStorage.specificItems:
		if item["owned"]:
			specific_mult(item["index"], item["mult"])
	
	for item in ItemStorage.directionItems:
		if item["owned"]:
			direction_mult(item["index"], item["mult"])
	
	base_mult_stack()
	ready_damage()

func ready_damage():
	for index in range(mults.size()):
		damage[index] = base_damage * mults[index]

func base_mult_stack():
	for index in range(20):
		var offset = index % 5
		if offset != 0:
			mults[index] *= mults[index - offset]

func direction_mult(index, mult):
	var iterator: int = 0
	while iterator < 20:
		if mults[iterator + index] > 0:
			mults[iterator + index] += mult
		iterator += 5

func specific_mult(index, mult):
	mults[index] += mult

func base_mult(mult):
	mults[0] 	+= mult
	mults[5] 	+= mult
	mults[10] 	+= mult
	mults[15] 	+= mult

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
		ItemStorage.money += (score * money_mult)
		SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")
