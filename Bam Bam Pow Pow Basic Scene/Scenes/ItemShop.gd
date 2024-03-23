extends CanvasLayer

var money = 0;
@onready var moneylabel = $Control/MarginContainer/HBoxContainer/MoneyLabel
@onready var icon = load("res://Assets/icon.svg")
@onready var item1 = $Control/MarginContainer/Item1
@onready var item2 = $Control/MarginContainer/Item2
@onready var item3 = $Control/MarginContainer/Item3

# Called when the node enters the scene tree for the first time.
func _ready():
	update_money(10000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_money(change):
	money = money+change
	moneylabel.text = "Money: " + str(money)

func bought_item(money):
	update_money(-money)
