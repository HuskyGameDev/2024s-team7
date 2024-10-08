extends CanvasLayer

@onready var equip1 = $Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem1
@onready var equip2 = $Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem2
@onready var equip3 = $Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem3
@onready var equip4 = $Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem4
@onready var equip5 = $Control/VBoxContainer/MarginContainer/HBoxContainer/EquippedItem5
@onready var item1 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem1
@onready var item2 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem2
@onready var item3 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem3
@onready var item4 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem4
@onready var item5 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsFirstRow/EquipItem5
@onready var item6 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem6
@onready var item7 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem7
@onready var item8 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem8
@onready var item9 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem9
@onready var item10 = $Control/VBoxContainer/MarginContainer2/HBoxContainer/ItemContainer/ItemsSecondRow/EquipItem10
@onready var maxPage = ceil(ItemStorage.itemMax/10.0)
signal reload


var page = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func valpage():
	if (page < 1):
		page = maxPage
	elif (page > maxPage):
		page = 1

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


func _on_button_pressed() -> void:
	pass # Replace with function body.
