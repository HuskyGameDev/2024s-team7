extends CanvasLayer

signal faded
signal norm

func fade_to_black():
	$AnimationPlayer.play("fade_to_black")

func fade_to_norm():
	$AnimationPlayer.play("fade_to_norm")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("faded")
	if anim_name == "fade_to_norm":
		emit_signal("norm")
