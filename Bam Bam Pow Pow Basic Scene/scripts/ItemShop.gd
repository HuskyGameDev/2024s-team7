extends CanvasLayer

@onready var moneylabel = $Control/MarginContainer/MarginContainer2/MoneyLabel

signal reload

# Called when the node enters the scene tree for the first time.
func _ready():
	moneylabel.text = "Money: " + str(ItemStorage.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("R"):
		print("Items: ")
		ItemStorage.printItems()

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
