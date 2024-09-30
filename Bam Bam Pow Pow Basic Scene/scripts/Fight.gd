extends Node

@onready var enemy = $enemy
@onready var player = $player
@onready var time = $Timer
@onready var score_label = $HBoxContainer/score
@onready var time_label = $HBoxContainer/time

var started = false

func _input(event):
	if !started && event is InputEventKey:
		started = true
		player.position += Vector2(275, 0)
		time.start()

func _process(delta):
	score_label.text = "Score: " + str(enemy.score)
	time_label.text = "Time: " + "%.3f" % time.time_left
	$HBoxContainer/TextureProgressBar.value = 5*(20-time.time_left)

func _on_timer_timeout():
	enemy.calc_money()

func _on_enemy_show_dmg(dmgNumber):
	var damage_label = Label.new()
	enemy.add_child(damage_label)
	damage_label.text = str(dmgNumber)
	damage_label.set("theme_override_colors/font_color", Color.DARK_RED)
	damage_label.set("theme_override_font_sizes/font_size", 30)
	var rand1 = randi_range(0, 50)
	var rand2 = randi_range(0, 30)
	var neg = 1 if randi_range(0, 1) == 0 else -1
	damage_label.position += Vector2(-30 + (rand1 * neg) + rand2, -40 + rand1 + rand2 -10)
	await get_tree().create_timer(0.2).timeout
	enemy.remove_child(damage_label)
