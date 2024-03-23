extends CanvasLayer

signal bought_item(money)
@onready var money_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var buy_button = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var sprite = $Control/MarginContainer/VBoxContainer/HBoxContainer/Sprite2D
@onready var IDNode = $Control/MarginContainer/VBoxContainer/HBoxContainer/Node
@onready var id = IDNode.get_meta("ID")

var money;

# Called when the node enters the scene tree for the first time.
func _ready():
	if (ItemStorage.itemsList[id][4] == false): 
		money = ItemStorage.itemsList[id][2]
		money_label.text = "Price: " + str(ItemStorage.itemsList[id][2])
		sprite.texture = load(ItemStorage.itemsList[id][3])
	else: 
		money_label.visible = false
		buy_button.visible = false
		sprite.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	money_label.visible = false
	buy_button.visible = false
	sprite.visible = false
	ItemStorage.itemsList[id][4] = true
	emit_signal("bought_item", money)
