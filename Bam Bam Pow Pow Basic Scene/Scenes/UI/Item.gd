extends CanvasLayer

signal bought_item(money)
@onready var money_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var buy_button = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var sprite = $Control/MarginContainer/VBoxContainer/HBoxContainer/Sprite2D
@onready var IDNode = $Control/MarginContainer/VBoxContainer/HBoxContainer/Node
@onready var item_storage = get_node("/root/ItemStorage")
@onready var id = IDNode.get_meta("ID")

var money;

# Called when the node enters the scene tree for the first time.
func _ready():
	money = item_storage.itemsList[id][2]
	money_label.text = "Price: " + str(item_storage.itemsList[id][2])
	sprite.texture = load(item_storage.itemsList[id][3])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	money_label.visible = false
	buy_button.visible = false
	sprite.visible = false
	item_storage.itemsList[id][4] = true
	emit_signal("bought_item", money)
