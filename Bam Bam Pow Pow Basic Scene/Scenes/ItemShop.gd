extends CanvasLayer

@onready var item_storage = get_node("/root/ItemStorage")
@onready var moneylabel = $Control/MarginContainer/HBoxContainer/MoneyLabel
@onready var item1 = $Control/MarginContainer/Item1
@onready var item2 = $Control/MarginContainer/Item2
@onready var item3 = $Control/MarginContainer/Item3

# Called when the node enters the scene tree for the first time.
func _ready():
	moneylabel.text = "Money: " + str(item_storage.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("R"):
		print("Items: ")
		item_storage.printItems()

func update_money(change):
	item_storage.money = item_storage.money+change
	moneylabel.text = "Money: " + str(item_storage.money)

func bought_item(money):
	update_money(-money)


func _on_fight_scene_button_pressed():
	SceneSwap.scene_swap("res://main.tscn");

func _on_main_menu_button_pressed():
	SceneSwap.scene_swap("res://Scenes/MainMenu.tscn");
