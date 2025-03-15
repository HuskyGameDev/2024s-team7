extends CanvasLayer

@onready var moneylabel = $Control/MarginContainer/MarginContainer2/MoneyLabel
@onready var item1 = $MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item1
@onready var item2 = $MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item2
@onready var item3 = $MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item3
@onready var item4 = $MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item4
@onready var item5 = $MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item5
@onready var item6 = $MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item6
@onready var item7 = $MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item7
@onready var item8 = $MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item8
@onready var warning = $HazardButton2
@onready var maxPage = ceil(ItemStorage.itemMax/8.0)
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var exitButton = $Control/Sprite2dButton
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
const Chime = preload("res://resources/sounds/StartChime.wav")


var page = 1 # The item shop always starts on page 1


signal reload

var speed_flash = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	# ItemStorage.money += 10000
	moneylabel.text = "Money: " + str(ItemStorage.money)
	#print(warning.modulate)
	
	if WeaponInShop.itemsOpened == false:
		Dialogic.start('itemShop')
	WeaponInShop.itemsOpened = true


func _process(delta: float) -> void:
	if warning.modulate.a > 0.99:
		speed_flash *= -1
	elif warning.modulate.a < 0.5:
		speed_flash *= -1
	warning.modulate = Color(1, 1, 1, warning.modulate.a + speed_flash * delta)
	if Input.is_key_pressed(KEY_W):
		print(ItemStorage.maxequips)

# A helper function to add money to the players money and display it
func update_money(change):
	ItemStorage.money = ItemStorage.money+change
	moneylabel.text = "Money: " + str(ItemStorage.money)

# Helper function to subtract money from the players total when they buy an item
func bought_item(money):
	update_money(-money)

# A series of functions that are used to transition to new scenes
func _on_fight_scene_button_pressed():
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn");

func _on_main_menu_button_pressed():
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn");

func _on_weapon_shop_button_pressed():
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/WeaponShop.tscn");

func _on_equip_button_pressed() -> void:
	if (!audio_stream_player.is_playing()):
			audio_stream_player.stream = WOOD_CLICK
			audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/EquipScreen.tscn");

func _on_settings_menu_button_pressed():
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn");

# Redirection to save game function in item_storage script
func _on_save_button_pressed():
	audio_stream_player.stream = Chime
	audio_stream_player.play()
	ItemStorage.save_game()

# When load game button is pressed, load it and update money and items
func _on_load_button_pressed():
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	ItemStorage.load_game()
	moneylabel.text = "Money: " + str(ItemStorage.money)
	emit_signal("reload")

# Ensures page number never goes past what is allowed
func valpage():
	if (page < 1):
		page = maxPage
	elif (page > maxPage):
		page = 1

# When the next page button is pressed
func _on_next_page_button_pressed() -> void:
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	# Increment page and ensure it is still within bounds of available pages
	page += 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to it+10. If that is above the
	# max number of items, change it instead to 0+i. Finally, reload that item.
	for i in 8:
		var curr_item;
		var curr_item_num;
		if (i < 4):
			curr_item_num = "MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item" + str(i+1)
		else:
			curr_item_num = "MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") + 8) >= maxPage*8):
			curr_item.set_meta("ID", i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")+8)
		curr_item._on_item_shop_reload()

# When the last page button is pressed
func _on_last_page_button_pressed() -> void:
	audio_stream_player.stream = WOOD_CLICK
	audio_stream_player.play()
	# Decrement page and ensure it is still within the bounds of available pages
	page -= 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to it-10. If that is below
	#0, change it instead to max-i. Finally, reload that item.
	for i in 8:
		var curr_item;
		var curr_item_num;
		if (i < 4):
			curr_item_num = "MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item" + str(i+1)
		else:
			curr_item_num = "MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") - 8) < 0):
			curr_item.set_meta("ID", ((maxPage-1)*8)+i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")-8)
		curr_item._on_item_shop_reload()


##--------------------
## HAZARD SCREEN 10/6/24
## Hazard screen is a temporary popup that explains to the user
## the current problems with WeaponShop for playtest

## When hazard button is clicked: warning popup screen is shown
func _on_hazard_button_pressed():
	$WarningScreen.visible = !$WarningScreen.visible	# Warning popup

## When close button is clicked: warning popup screen is closed
func _on_close_pressed():
	$WarningScreen.hide()	# Close Warning popup


func _on_sprite_2d_button_sprite_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

func _on_sprite_2d_button_mouse_entered():
	exitButton.frame = 1

func _on_sprite_2d_button_mouse_exited():
	exitButton.frame = 0


func _on_hazard_button_2_mouse_entered():
	warning.frame = 0

func _on_hazard_button_2_mouse_exited():
	warning.frame = 1

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn")
