extends CanvasLayer

# Get reference to equip/unequip button, cancel selection button,
# the maximum number of pages, and the currently selected id
@onready var equip_unequip_button = $Control/VBoxContainer/MarginContainer3/HBoxContainer/EquipButton
@onready var cancel_button = $Control/VBoxContainer/MarginContainer3/HBoxContainer/CancelButton
@onready var maxPage = ceil(ItemStorage.itemMax/10.0)
@onready var maxEquippedPage = ceil(ItemStorage.maxequips/5.0)
@onready var selected_id = -1
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
const WOOD_CLICK = preload("res://resources/sounds/WoodClick.wav")
signal reload


var page = 1
var equippedpage = 1

func _physics_process(delta: float) -> void:
	var direction: Vector2
	direction.x = Input.get_action_strength("R") - Input.get_action_strength("L") 
	direction.y = Input.get_action_strength("D") - Input.get_action_strength("U")
	var movement = Global.MOUSE_SPEED * direction * delta
	if (movement):
		get_viewport().warp_mouse(get_viewport().get_mouse_position()+movement)
	if Input.is_action_just_pressed("Light"):
		simulate_mouse_click()

func simulate_mouse_click():
	var mp = get_viewport().get_mouse_position()
	
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.position = mp
	event.pressed = true
	
	Input.parse_input_event(event)
	
	var r_event = InputEventMouseButton.new()
	r_event.button_index = MOUSE_BUTTON_LEFT
	r_event.position = mp
	r_event.pressed = false
	
	Input.parse_input_event(r_event)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make equip/unequip button and cancel selection button disappear
	equip_unequip_button.visible = false
	cancel_button.visible = false
	emit_signal("reload")
	reload_equipped()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Make sure current page is within allowed pages, else lop
func valpage():
	if (page < 1):
		page = maxPage
	elif (page > maxPage):
		page = 1

# Function for going to the next page
func _on_next_page_button_pressed() -> void:
	# Increment page and ensure it is still within bounds of available pages
	page += 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to the current metadata+10. 
	# If that is above the maximum page (Ie the page with the last items), change it instead to i. 
	# Finally, reload that item.
	for i in 10:
		var curr_item;
		var curr_item_num;
		if (i < 5):
			curr_item_num = "Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem" + str(i+1)
		else:
			curr_item_num = "Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") + 10) >= ceil(ItemStorage.itemMax/10.0)*10):
			curr_item.set_meta("ID", i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")+10)
		curr_item.on_reload()
	unselect()

# Function for going to the previous page
func _on_last_page_button_pressed() -> void:
	# Decrement page and ensure it is still within the bounds of available pages
	page -= 1
	valpage()
	# For each of the 10 items onscreen, find their path, then change their metadata to it-10. If that is below
	# 0, change it instead to the maximum page's first item + i (Ie going below 0 makes that page the last page)
	# Finally, reload that item.
	for i in 10:
		var curr_item;
		var curr_item_num;
		if (i < 5):
			curr_item_num = "Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem" + str(i+1)
		else:
			curr_item_num = "Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem" + str(i+1)
		curr_item = get_node(curr_item_num)
		if ((curr_item.get_meta("ID") - 10) < 0):
			curr_item.set_meta("ID", ((ItemStorage.itemMax/10)*10)+i)
		else:
			curr_item.set_meta("ID", curr_item.get_meta("ID")-10)
		curr_item.on_reload()
	unselect()

# Change the equipped items to have id's of whatever's in equipped_items array
# and reload them to display properly
func reload_equipped() -> void:
	for i in 5:
		var curr_eq_item 
		var curr_eq_item_num = "Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem" + str(i+1)
		curr_eq_item = get_node(curr_eq_item_num)
		curr_eq_item.set_meta("ID", ItemStorage.equipped_items[(equippedpage-1)*5+i])
		curr_eq_item.on_reload()

# When selecting a currently equipped item, make equip/unequip button say unequip,
# make it and cancel selection button visibile, and update selected id
func _on_equipped_item_selected_item(id: Variant) -> void:
	equip_unequip_button.visible = true
	equip_unequip_button.text = "Unequip"
	cancel_button.visible = true
	selected_id = id

# When selecting a currently unequipped item, make equip/unequip button say equip,
# make it and cancel selection button visibile, and update selected id
func _on_equip_item_selected_item(id: Variant) -> void:
	equip_unequip_button.visible = true
	if (ItemStorage.itemsList[id]["equipped"] == false):
		equip_unequip_button.text = "Equip"
	else:
		equip_unequip_button.text = "Unequip"
	cancel_button.visible = true
	selected_id = id

# When the equip/unequip button is pressed, equip or unequip depending on current selection
func _on_equip_button_pressed() -> void:
	# If currently selected item is unequipped and there are less than 5 items equipped (max)
	# equip the currently selected item and show it, then unselect the item
	if (ItemStorage.itemsList[selected_id]["equipped"] == false):
		var equipped = 0
		for i in ItemStorage.maxequips:
			if (ItemStorage.equipped_items[i] != -1):
				equipped = equipped + 1
		if (equipped != ItemStorage.maxequips):
			ItemStorage.itemsList[selected_id]["equipped"] = true
			for i in ItemStorage.maxequips:
				if (ItemStorage.equipped_items[i] == -1):
					ItemStorage.equipped_items[i] = selected_id
					break
			reload_equipped()
			unselect()
	else:
		# If currently selected item is equipped, unequip it and remove it from the equipped
		# item list, then shift down equipped items positions and show the change and unselect
		# the current item
		ItemStorage.itemsList[selected_id]["equipped"] = false
		for i in ItemStorage.maxequips:
			if (ItemStorage.equipped_items[i] == selected_id):
				ItemStorage.equipped_items[i] = -1
				for j in range(i,ItemStorage.maxequips):
					if (j != ItemStorage.maxequips-1 && ItemStorage.equipped_items[j+1] != -1):
						ItemStorage.equipped_items[j] = ItemStorage.equipped_items[j+1]
					else:
						ItemStorage.equipped_items[j] = -1
					
		reload_equipped()
		unselect()

# Helper function that removes the equip/unequip and cancel buttons and sets selected_id
# to -1 (nonexistant id)
func unselect() -> void:
	equip_unequip_button.visible = false
	cancel_button.visible = false
	selected_id = -1

# When cancel button is pressed, run unselect function
func _on_cancel_button_pressed() -> void:
	unselect()


func _on_main_menu_button_pressed():
	if (!audio_stream_player.is_playing()):
			audio_stream_player.stream = WOOD_CLICK
			audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/MainMenu.tscn");

func _on_weapon_shop_button_pressed():
	if (!audio_stream_player.is_playing()):
			audio_stream_player.stream = WOOD_CLICK
			audio_stream_player.play()
	SceneSwap.scene_swap("res://Scenes/Playable/WeaponShop.tscn");


func _on_item_scene_button_pressed() -> void:
	if (!audio_stream_player.is_playing()):
			audio_stream_player.stream = WOOD_CLICK
			audio_stream_player.play()
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn");


func _on_fight_scene_button_pressed() -> void:
	if (!audio_stream_player.is_playing()):
			audio_stream_player.stream = WOOD_CLICK
			audio_stream_player.play()
	Global.prev_scene = get_tree().current_scene.scene_file_path
	SceneSwap.scene_swap("res://Scenes/Playable/Fight.tscn");

func valequippedpage():
	if (equippedpage < 1):
		equippedpage = maxEquippedPage
	elif (equippedpage > maxEquippedPage):
		equippedpage = 1


func _on_equipped_last_page_button_pressed() -> void:
	equippedpage -= 1
	valequippedpage()
	for i in 5:
		var curr_eq_item 
		var curr_eq_item_num = "Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem" + str(i+1)
		curr_eq_item = get_node(curr_eq_item_num)
		if (((equippedpage-1)*5)+i < ItemStorage.maxequips):
			curr_eq_item.set_meta("ID", ItemStorage.equipped_items[((equippedpage-1)*5)+i])
		else:
			curr_eq_item.set_meta("ID", -1)
		curr_eq_item.on_reload()
	unselect()


func _on_equipped_next_page_button_pressed() -> void:
	equippedpage += 1
	valequippedpage()
	for i in 5:
		var curr_eq_item 
		var curr_eq_item_num = "Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem" + str(i+1)
		curr_eq_item = get_node(curr_eq_item_num)
		if (((equippedpage-1)*5)+i < ItemStorage.maxequips):
			curr_eq_item.set_meta("ID", ItemStorage.equipped_items[((equippedpage-1)*5)+i])
		else:
			curr_eq_item.set_meta("ID", -1)
		curr_eq_item.on_reload()
	unselect()
