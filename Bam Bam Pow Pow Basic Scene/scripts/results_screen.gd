extends Control
# TODO: Would like a fade in. Pretty abrupt as-is.

@onready var result_type_animation = $MarginContainer/ResultTypeAnimation
@onready var result_image_animation = $MarginContainer/ResultImageAnimation

@onready var record_label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/RecordContainer/RecordLabel
@onready var record = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/RecordContainer/Record
@onready var score_label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/ScoreContainer/ScoreLabel
@onready var score = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/ScoreContainer/Score
@onready var coins_label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/CoinsCointainer/CoinsLabel
@onready var coins = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/CoinsCointainer/Coins
@onready var combo_label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/ComboContainer/ComboLabel
@onready var combo = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/ComboContainer/Combo
@onready var score_container = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/ScoreContainer

@onready var win = FightDetails.win

# Go to settings on esc
func _input(event):
	if Input.is_action_just_pressed('Esc'):
		SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (FightDetails.infinity):
		_change_score()
		_change_coins_positive()
		_change_record_score()
		_change_combo()
		result_image_animation.flip_h = true
	else:
		if (!win):
			_change_score()
			_change_coins_negative()
			result_type_animation.play("shattered")
			result_image_animation.play("loss")
		if (win):
			FightDetails.win = false
			score_container.hide()
			_change_coins_positive()
			_change_record_seconds()
			result_type_animation.play("victory")
			result_image_animation.play("victory")
		_change_combo()
		
func _change_score():
	score.text = str(Global.score)
	
func _change_coins_positive():
	ItemStorage.money += (Global.added_coins)
	coins_label.text = "+Coins"
	coins.text = str(Global.added_coins)
	
func _change_coins_negative():
	ItemStorage.money -= (Global.added_coins)
	coins_label.add_theme_color_override("font_color", "red")
	coins.add_theme_color_override("font_color", "red")
	coins_label.text = "-Coins"
	coins.text = "-300"

func _change_record_score():
	if(Global.score > FightDetails.high_score):
		FightDetails.high_score = Global.score
		record.add_theme_color_override("font_color", "yellow")
		record_label.add_theme_color_override("font_color", "yellow")
		record_label.text = "(New!) Record:"
	record.text = str(FightDetails.high_score)

func _change_record_seconds():
	if(Global.time_left < FightDetails.op_list[FightDetails.op_progress]["record"]):
		FightDetails.op_list[FightDetails.op_progress]["record"] = Global.time_left
		record.add_theme_color_override("font_color", "yellow")
		record_label.add_theme_color_override("font_color", "yellow")
		record_label.text = "(New!) Record:"
	record.text = (str(FightDetails.op_list[FightDetails.op_progress]["record"]).pad_decimals(2) + "s")
func _change_combo():
	combo.text = str(Global.combo)

func _on_button_pressed() -> void:
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
