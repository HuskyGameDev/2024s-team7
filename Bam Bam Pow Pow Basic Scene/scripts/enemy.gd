extends CharacterBody2D

class_name Enemy

signal hit
signal x_pos(position)

@export var max_health = 1000
@export var current_health = max_health

@export var weight: float = 100
@export var damage: int
@export var score: int = 0
@export var combo: int = 0
@export var base_damage: int = 10
@export var juggle: float = 1

@onready var debuff_indicator = $DebuffIndicator
@onready var sprite = $Sprite2D
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer
@onready var player = $"../player"

@onready var audioPlayer = get_node("%AudioStreamPlayer")


#@onready var hit_noise1 = preload("res://resources/Hit1.wav")
#@onready var hit_noise2 = preload("res://resources/Hit2.wav")
#@onready var hit_noise3 = preload("res://resources/Hit3.wav")

var attack_performed: String
var player_dir
var stale: int = 0

var addedMoney = false

@onready var items = ItemStorage.itemsList
var money_mult = 1.0 # Multiplier for money stats

var mults: Dictionary = {
	"money": 0,
	"base": 0,
	"light": 0,
	"light_neutral": 0,
	"light_up": 0,
	"light_down": 0,
	"light_side": 0,
	"light_air": 0,
	"heavy": 0,
	"heavy_neutral": 0,
	"heavy_up": 0,
	"heavy_down": 0,
	"heavy_side": 0,
	"heavy_air": 0,
}

var resistances: Dictionary = {
	"PHYSICAL": 0,
	"FIRE": 0,
	"COLD": 0,
	"ELECTRIC": 0
}

signal damage_readied(damage_array)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animPlayer.play("idle")
	ready_mults()
	print(audioPlayer)


# Alters the damageMult and money_mult variables depending on items the player has bought from the shop
func ready_mults():
	# This is adding up all of the multipliers and storing them in the 
	# dictionary in the item storage global.
	for index in ItemStorage.equipped_items:
		if index != -1:
			var effects = ItemStorage.itemsList[index]["effects"]
			for key in effects:
				mults[key] += effects[key] ## TODO: not initializing to 1 whenever hte fight loads
	ready_damage()
	# Send the calcualted damage array to the combo script

## This function will apply all of the multipliers to the player's weapon
## attacks
func ready_damage():
	## TODO: Apply the multipliers to the attacks on the current weapon the 
	## player has 
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

	x_pos.emit(position.x)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * weight/100
	if is_on_floor():
		if velocity.x != 0:
			if velocity.x > 0:
				velocity.x -= weight/50 + velocity.x*0.1
			if velocity.x < 0:
				velocity.x += weight/50 - velocity.x*0.1
		if self.combo > Global.combo:
			Global.combo = self.combo
		self.juggle = 0
		self.combo = 0
		self.stale = 0

	move_and_slide()


## This function will apply a modification to the enemy's resistance to the
## given type.
##
## Parameters:
## resistance		String: This is the type of resistance that is to be modified.
## modification		float: This is the modification to be applied to that resistance. 
##
## Returns:
## void: There is no return, this change is internal.
func change_resistance(resistance: String, modification: float) -> void:
	resistances[resistance] += modification
	## Temporary line
	debuff_indicator.visible = !debuff_indicator.visible

var damage_delt = 0;

signal showDmg(dmgNumber)


func _on_hurtbox_area_entered(hitbox):
	audioPlayer.stop()
	if (!audioPlayer.is_playing()):
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,4)
		var stream = "res://resources/sounds/womp_" + str(rand) + ".wav"
		var stream2 = load(stream)
		audioPlayer.set_stream(stream2)
		audioPlayer.play()
	
	damage = player.weapon[attack_performed].damage + 0.2 * (player.weapon[attack_performed].damage * self.juggle)
	damage *= player.weapon[attack_performed].mult
	damage = calc_resistance(damage, player.weapon[attack_performed].damage_type)
	
	self.score += damage
	self.current_health = clamp((self.current_health - damage), 0, self.max_health)
	hit.emit()

	self.combo += 1
	self.juggle += 0.5

	
	animPlayer.play("hurt")
	showDmg.emit(damage)
	
	velocity.x = 0;
	velocity.y = 0;
	
	stale += player.weapon[attack_performed].hit_stun
	
	if player.weapon[attack_performed].knockback < 0:
		velocity.x += float((-10*player.weapon[attack_performed].knockback)) * player_dir 
	else:
		velocity.x += float((10*player.weapon[attack_performed].knockback)) * player_dir
	velocity.y -= float((10*player.weapon[attack_performed].angle)) - (combo * .01) * stale
	
	#player.velocity.x *= .01
	player.velocity.y *= .75
	
	print(hitbox.get_parent().name + "'s hitbox touched " + name)
	print(str(damage) + " dealt!")
	print("Juggle Count: " + str(self.juggle))
	


## This function will determine if the enemy is either resistant or weak to a
## certain damage type and apply the approriate modifications to the damage.
##
## Parameters:
## dmg_dealt	float: This is the base damage value of the attack after all 
## 					   multipliers have been calculated.
## dmg_type		String: This is the type of damage dealt by the attack so that
## 						it can be used to check what the enemy resistance is to 
## 						this attack.
##
## Returns:
## float: This will be the resulting damage after it has been modified by the
## enemy resistances.
func calc_resistance(dmg_dealt: float, dmg_type: String) -> float:
	return dmg_dealt - (dmg_dealt * resistances[dmg_type])


func calc_money():
	var addedtotal: int = score * money_mult
	Global.score = score
	ItemStorage.money += (addedtotal)
	# SceneSwap.scene_swap("res://Scenes/Playable/ResultsScreen.tscn")

func _on_player_attack(attack):
	attack_performed = attack
		

func _on_player_player_dir(dir):
	player_dir = dir
