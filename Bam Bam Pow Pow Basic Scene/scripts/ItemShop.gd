extends CanvasLayer

@onready var moneylabel = $Control/MarginContainer/MarginContainer2/MoneyLabel
@onready var item1 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item1
@onready var item2 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item2
@onready var item3 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item3
@onready var item4 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item4
@onready var item5 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item5
@onready var item6 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item6
@onready var item7 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item7
@onready var item8 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item8
@onready var item9 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item9
@onready var item10 = $Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item10

var page = 1; # The item shop always starts on page 1

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
	if (page < 0):
		page = 3
	elif (page >= 4):
		page = 0

# When the next page button is pressed
func _on_next_page_button_pressed() -> void:
	# Increment page and ensure it is still within bounds of available pages
	page += 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to it+10. If that is above the
	# max number of items, change it instead to 0+i. Finally, reload that item.
	for i in 10:
		var curr_item;
		var curr_item_num;
		if (i < 5):
			curr_item_num = "Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item" + str(i+1)
		else:
			curr_item_num = "Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") + 10) >= ItemStorage.itemMax):
			curr_item.set_meta("ID", 0+i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")+10)
		curr_item._on_item_shop_reload()

# When the last page button is pressed
func _on_last_page_button_pressed() -> void:
	# Decrement page and ensure it is still within the bounds of available pages
	page -= 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to it-10. If that is below
	#0, change it instead to max-i. Finally, reload that item.
	for i in 10:
		var curr_item;
		var curr_item_num;
		if (i < 5):
			curr_item_num = "Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsFirstRow/Item" + str(i+1)
		else:
			curr_item_num = "Control/MarginContainer/MarginContainer/HBoxContainer/ItemContainer/ItemsSecondRow/Item" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") - 10) < 0):
			curr_item.set_meta("ID", ItemStorage.itemMax-10+i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")-10)
		curr_item._on_item_shop_reload()
