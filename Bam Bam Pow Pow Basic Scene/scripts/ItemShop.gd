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
@onready var maxPage = ceil(ItemStorage.itemMax/8.0)



var page = 1 # The item shop always starts on page 1


signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	ItemStorage.money += 1000
	moneylabel.text = "Money: " + str(ItemStorage.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if Input.is_action_just_pressed("R"):
	#	print("Items: ")
	#	ItemStorage.printItems()
	pass

func update_money(change):
	ItemStorage.money = ItemStorage.money+change
	moneylabel.text = "Money: " + str(ItemStorage.money)

func bought_item(money):
	update_money(-money)


func _on_fight_scene_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn");

func _on_main_menu_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn");

func _on_weapon_shop_button_pressed():
	SceneSwap.scene_swap("res://Scenes/Playable/WeaponShop.tscn");

func _on_settings_menu_button_pressed():
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/SettingsMenu.tscn");
	
func _on_save_button_pressed():
	ItemStorage.save_game()

func _on_load_button_pressed():
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
		print(curr_item.get_meta("ID"))

# When the last page button is pressed
func _on_last_page_button_pressed() -> void:
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
		print(curr_item.get_meta("ID"))
