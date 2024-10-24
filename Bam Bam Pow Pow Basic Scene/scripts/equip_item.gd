extends VBoxContainer

signal selected_item(id)

# Get the sprite, button, name label, and equip screen references
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

# When select button is pressed, tell the equip screen it was and the id of this item
func _on_button_pressed() -> void:
	emit_signal("selected_item", id)

# When scene is reloaded, get the id of this item and check it against the item max
func on_reload() -> void:
	id = self.get_meta("ID")
	var lessThanMax = (id < ItemStorage.itemMax)
	# If item is higher than the maximum amount of items, hide it so the last page
	# shows properly
	if (lessThanMax == false):
		sprite.visible = false
		button.visible = false
		namelabel.visible = false
	# If the item is not owned by the player, only show its sprite
	elif (ItemStorage.itemsList[id].owned == false):
		sprite.visible = true
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/Shop_sprites.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]
		button.visible = false
		namelabel.visible = false
	# If the item is owned by the player, show its sprite, name, and select button
	else:
		sprite.visible = true
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/Shop_sprites.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]
		button.visible = true
		namelabel.visible = true
		namelabel.text = ItemStorage.itemsList[id]["name"]
		
