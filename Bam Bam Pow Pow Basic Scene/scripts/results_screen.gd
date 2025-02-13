extends Control

@onready var score = $VBoxContainer/Score
@onready var combo = $VBoxContainer/Combo
@onready var results = $VBoxContainer/Results
@onready var ScoreLabel = $VBoxContainer/ScoreLabel
@onready var ComboLabel = $VBoxContainer/ComboLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = ''
	combo.text = ''
	score.push_bold()
	score.push_color(Color.BLACK)
	score.push_font_size(30)
	combo.push_bold()
	combo.push_color(Color.BLACK)
	combo.push_font_size(30)
	score.append_text(str(Global.score))
	combo.append_text(str(Global.combo))
	score.pop_all()
	combo.pop_all()

func _on_button_pressed() -> void:
	SceneSwap.scene_swap("res://Scenes/Playable/SelectionScreen.tscn")
