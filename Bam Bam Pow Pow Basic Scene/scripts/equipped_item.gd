extends VBoxContainer

signal selected_item(id)

# Set up the id, then get the sprite, select button, name label, and equip screen references
var id
@onready var sprite = $SpriteContainer/Sprite2D
@onready var button = $Button
@onready var namelabel = $Label
@onready var equip_screen = get_node("/root/EquipScreen")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	equip_screen.connect("reload", on_reload)
	on_reload()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When select button is pressed, tell the equip screen and that this item was selected
func _on_button_pressed() -> void:
	emit_signal("selected_item", id)

# On reload, get the id of this item
func on_reload() -> void:
	id = self.get_meta("ID")
	# If the id of this item is < 0 (non-existant), don't show this item
	if (id < 0):
		sprite.visible = false
		button.visible = false
		namelabel.visible = false
	# If this item is owned and equipped, show it's sprite, name, and select button
	elif (ItemStorage.itemsList[id].owned == true && ItemStorage.itemsList[id].equipped == true):
		sprite.visible = true
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/combined_playtest_3_spritesheet.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]
		button.visible = true
		namelabel.visible = true
		namelabel.text = ItemStorage.itemsList[id]["item_name"]
	# If the above are not met, show nothing as a failsafe
	else:
		sprite.visible = false
		button.visible = false
		namelabel.visible = false


func _on_sprite_2d_mouse_entered() -> void:
	sprite.frame += 24


func _on_sprite_2d_mouse_exited() -> void:
	sprite.frame -= 24

func _on_sprite_2d_sprite_button_pressed():
	# print("the button worked awooga")
	#Dialogic.set_variable('ItemDescript', 'awooooga')
	var lines = ItemStorage.itemsList[id]["descript"]
	Dialogic.VAR.ItemDescript = lines

	Dialogic.start('itemDescriptions')
