extends Node

@onready var enemy = $enemy
@onready var player = $player
@onready var time = $Timer
@onready var score_label = $HBoxContainer/score
@onready var combo_label = $HBoxContainer/VBoxContainer/combo
@onready var time_label = $HBoxContainer/time
@onready var input_screen = $WarningScreen
@onready var audio_timer: AudioStreamPlayer = $AudioTimer
@onready var fiveSecond_noise = preload("res://resources/sounds/fiveseconds.wav")
var started = false


func _ready():
	FightDetails.infinity = true
	if (ItemStorage.inputtoggle == true):
		input_screen.visible = true
	else:
		input_screen.visible = false
	

func _input(event):
	if !started && event is InputEventKey:
		input_screen.visible = false
		started = true
		Global.combo = 0
		time.start()

func _process(delta):
	score_label.text = "Score: " + str(enemy.score)
	combo_label.text = "x" + str(enemy.combo)
	time_label.text = "Time: " + "%.3f" % time.time_left
	$HBoxContainer/TextureProgressBar.value = (100/time.wait_time)*(time.wait_time-time.time_left)
	if time.time_left < 5 && time.time_left > 4 && (!audio_timer.is_playing()):
			audio_timer.stream = fiveSecond_noise
			audio_timer.play()
	

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
