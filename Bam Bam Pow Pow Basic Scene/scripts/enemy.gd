extends CharacterBody2D

# Add class for reference
class_name Enemy

# Campaign Specific Variables
signal health_changed

@export var max_health = 100
@onready var current_health = max_health

# Original Variables

@export var hp: int = 1
@export var weight: float = 100
@export var score: int = 0
@export var base_damage: int = 10
@export var juggle: float = 1

@onready var sprite = $Sprite2D
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer
@onready var player = $"../player"

var addedMoney = false

@onready var items = ItemStorage.itemsList
var money_mult = 1.0 # Multiplier for money stats

signal damage_readied(damage_array)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")
	ready_mults()

# Alters the damageMult and money_mult variables depending on items the player has bought from the shop
func ready_mults():
	# This is adding up all of the multipliers and storing them in the 
	# dictionary in the item storage global.
	for item in ItemStorage.owned_items:
		var effects = item["effects"]
		for key in effects:
			ItemStorage.mults[key] += effects[key] ## TODO: not initializing to 1 whenever hte fight loads
			
	ready_damage()
	# Send the calcualted damage array to the combo script

## This function will apply all of the multipliers to the player's weapon
## attacks
func ready_damage():
	## TODO: Apply the multipliers to the attacks on the current weapon the 
	## player has 
	var mults = ItemStorage.mults
	money_mult += mults["money"]
	all_light(mults["base"])
	all_heavy(mults["base"])
	all_light(mults["light"])
	all_heavy(mults["heavy"])
	player.weapon.light_neutral.mult	+= mults["light_neutral"]
	player.weapon.light_up.mult			+= mults["light_up"]
	player.weapon.light_down.mult		+= mults["light_down"]
	player.weapon.light_side.mult		+= mults["light_side"]
	player.weapon.light_air.mult		+= mults["light_air"]
	player.weapon.heavy_neutral.mult	+= mults["heavy_neutral"]
	player.weapon.heavy_up.mult			+= mults["heavy_up"]
	player.weapon.heavy_down.mult		+= mults["heavy_down"]
	player.weapon.heavy_side.mult		+= mults["heavy_side"]
	player.weapon.heavy_air.mult		+= mults["heavy_air"]
	

## This function will apply a light mutliplier to all of the light attacks
##
## Parameters:
## mult		float: This is the mult to add
func all_light(mult: float):
	player.weapon.light_neutral.mult	+= mult
	player.weapon.light_up.mult 		+= mult
	player.weapon.light_down.mult	 	+= mult
	player.weapon.light_side.mult 		+= mult
	player.weapon.light_air.mult 		+= mult
	
## This function will apply a heavy mutliplier to all of the heavy attacks
##
## Parameters:
## mult		float: This is the mult to add
func all_heavy(mult: float):
	player.weapon.heavy_neutral.mult	+= mult
	player.weapon.heavy_up.mult 		+= mult
	player.weapon.heavy_down.mult	 	+= mult
	player.weapon.heavy_side.mult 		+= mult
	player.weapon.heavy_air.mult 		+= mult

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * weight/100
	if is_on_floor():
		self.juggle = 1

	move_and_slide()

var damage_delt = 0;

func _on_combo_handler_attack_damamge(damage_number):
	damage_delt = damage_number

signal showDmg(dmgNumber)


func _on_hurtbox_area_entered(hitbox):
	self.juggle += 0.2
	var damage = damage_delt * self.juggle * hitbox.motion
	self.score += damage
	animPlayer.play("hurt")
	showDmg.emit(damage)
	velocity.y = 0;
	velocity.y -= float((100*hitbox.weight))
	print(hitbox.get_parent().name + "'s hitbox touched " + name)
	print(str(damage) + " dealt!")
	print("Juggle Count: " + str(self.juggle))

	if self.score >= 5000 && !addedMoney:
		addedMoney = true
		calc_money()
		
func calc_money():
		ItemStorage.money += (score * money_mult)
		SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")


func _on_combo_handler_attack(core: int, motion: int) -> void:
	print("Signal Recieved!")
	print("   Core: " + str(core))
	print("   Motion: " + str(core))
