extends Node

@onready var coinsSprite = $Coins
@onready var coinsLabel = $PigSpeech/MarginContainer/coinsLabel

@onready var coinsCount = ItemStorage.money
@onready var backToFightButton = $BackToFight
@onready var backToFightAnimationPlayer = $AnimationPlayer
@onready var punchy = $BackToFight/Punchy
@onready var campaignButton = $CampaignButton
@onready var trainingButton = $TrainingButton
@onready var soundPlayer = $AudioStreamPlayer2D
@onready var piggy_bank = $PiggyBank

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets FightDetails switch based on last chosen
	if FightDetails.infinity == false:
		campaignButton.frame = 1
		trainingButton.frame = 0
		trainingButton.z_index = 1

	coinsLabel.text = format_number(coinsCount)
	
	#coins sprite sometimes not set :/ idk why. coins label always good
	coinsSprite.frame = clamp(pow(coinsCount, 1/8.), 0, 7)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function stolen from the godot forums
func format_number(n: int) -> String:
	if n >= 1_000_000_000_000:
		# ran for every number <n> greater or equal to a trillion
		var i:float = snapped(float(n)/1_000_000_000_000, .01)
		return str(i).replace(",", ".") + "B"
	elif n >= 1_000_000:
		# ran for every number <n> smaller than 1 trillion BUT
		# still greater or equal to 1 million
		var i:float = snapped(float(n)/1_000_000, .01)
		return str(i).replace(",", ".") + "M"
	elif n >= 1_000:
		# ran for every number <n> smaller than 1 million BUT
		# still greater or equal to 1 thousand
		var i:float = snapped(float(n)/1_000, .01)
		return str(i).replace(",", ".") + "k"
	else:
		# ran otherwise
		return str(n)


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

func _on_back_to_fight_mouse_entered():
	match backToFightAnimationPlayer.current_animation:
		"FightButton":
			backToFightAnimationPlayer.play("HoverFightButton")
		"PressFightButton":
			backToFightAnimationPlayer.play("HoverPressFightButton")
	punchy.play("hoverPunch")

func _on_back_to_fight_mouse_exited():
	match backToFightAnimationPlayer.current_animation:
		"HoverFightButton":
			backToFightAnimationPlayer.play("FightButton")
		"HoverPressFightButton":
			backToFightAnimationPlayer.play("PressFightButton")
	punchy.play("idleFists")

func _on_back_to_fight_button_down():
	match backToFightAnimationPlayer.current_animation:
		"FightButton":
			backToFightAnimationPlayer.play("PressFightButton")
		"HoverFightButton":
			backToFightAnimationPlayer.play("HoverPressFightButton")

func _on_back_to_fight_button_up():
	match backToFightAnimationPlayer.current_animation:
		"PressFightButton":
			backToFightAnimationPlayer.play("FightButton")
		"HoverPressFightButton":
			backToFightAnimationPlayer.play("HoverFightButton")


func _on_campaign_button_sprite_button_pressed():
	FightDetails.infinity = false
	campaignButton.frame = 1
	campaignButton.z_index = 0
	trainingButton.frame = 0

func _on_training_button_sprite_button_pressed():
	FightDetails.infinity = true
	campaignButton.frame = 0
	campaignButton.z_index = 1
	trainingButton.frame = 1

func _on_piggy_bank_sprite_button_pressed():
	soundPlayer.stream = load("res://resources/sounds/oink.mp3")
	piggy_bank.frame = 2
	await get_tree().create_timer(.1).timeout
	soundPlayer.play()


func _on_audio_stream_player_2d_finished():
	piggy_bank.frame = 3
	await get_tree().create_timer(1).timeout
	piggy_bank.frame = 4
	await get_tree().create_timer(1).timeout
	piggy_bank.frame = 1
