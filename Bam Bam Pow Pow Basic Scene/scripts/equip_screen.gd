extends CanvasLayer

# Get reference to equip/unequip button, cancel selection button,
# the maximum number of pages, and the currently selected id
@onready var equip_unequip_button = $Control/VBoxContainer/MarginContainer3/HBoxContainer/EquipButton
@onready var cancel_button = $Control/VBoxContainer/MarginContainer3/HBoxContainer/CancelButton
@onready var maxPage = ceil(ItemStorage.itemMax/10.0)
@onready var selected_id = -1
signal reload


var page = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make equip/unequip button and cancel selection button disappear
	equip_unequip_button.visible = false
	cancel_button.visible = false


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

# Change the equipped items to have id's of whatever's in equipped_items array
# and reload them to display properly
func reload_equipped() -> void:
	for i in 5:
		var curr_eq_item 
		var curr_eq_item_num = "Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem" + str(i+1)
		curr_eq_item = get_node(curr_eq_item_num)
		curr_eq_item.set_meta("ID", ItemStorage.equipped_items[i])
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
	equip_unequip_button.text = "Equip"
	cancel_button.visible = true
	selected_id = id

# When the equip/unequip button is pressed, equip or unequip depending on current selection
func _on_equip_button_pressed() -> void:
	# If currently selected item is unequipped and there are less than 5 items equipped (max)
	# equip the currently selected item and show it, then unselect the item
	if (ItemStorage.itemsList[selected_id]["equipped"] == false):
		var equipped = 0
		for i in 5:
			if (ItemStorage.equipped_items[i] != -1):
				equipped = equipped + 1
		if (equipped != 5):
			ItemStorage.itemsList[selected_id]["equipped"] = true
			for i in 5:
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
		for i in 5:
			if (ItemStorage.equipped_items[i] == selected_id):
				ItemStorage.equipped_items[i] = -1
				for j in range(i,5):
					if (j != 4 && ItemStorage.equipped_items[j+1] != -1):
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
