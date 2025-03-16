extends Node

@onready var coinsPic = $Coins
@onready var coinsLabel = $coinsLabel
@onready var fightTypeLabel = $FightTypeLabel
@onready var coinsCount = ItemStorage.money
@onready var fightTypeSwitch = $FightTypeSwitch

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets FightDetails switch based on last chosen
	if FightDetails.infinity == false:
		fightTypeSwitch.button_pressed = true
		
	coinsLabel.text = "Coins: " + str(coinsCount)
	coinsPic.frame = coinsCount/1000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_settings_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")


func _on_item_shop_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")


func _on_weapon_shop_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/WeaponShop.tscn")


func _on_inventory_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/EquipScreen.tscn")


func _on_exit_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn")

func _on_save_sprite_button_pressed():
	ItemStorage.save_game()

func _on_back_to_fight_sprite_button_pressed():
	if FightDetails.infinity:
		SceneSwap.scene_swap("res://Scenes/Playable/InfinityFight.tscn")
	else:
		SceneSwap.scene_swap("res://Scenes/Playable/CampaignFight.tscn")


func _on_fight_type_switch_toggled(toggled_on):
	if toggled_on:
		FightDetails.infinity = false
		fightTypeLabel.text = "Campaign"
	else:
		FightDetails.infinity = true
		fightTypeLabel.text = "Training"
