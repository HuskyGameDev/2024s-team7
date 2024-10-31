extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.text = ''
	$Combo.text = ''
	$Score.push_bold()
	$Score.push_color(Color.BLACK)
	$Score.push_font_size(30)
	$Combo.push_bold()
	$Combo.push_color(Color.BLACK)
	$Combo.push_font_size(30)
	$Score.append_text(str(Global.score))
	$Combo.append_text(str(Global.combo))
	$Score.pop_all()
	$Combo.pop_all()

func _on_button_pressed() -> void:
	SceneSwap.scene_swap("res://Scenes/Playable/ItemShop.tscn")
