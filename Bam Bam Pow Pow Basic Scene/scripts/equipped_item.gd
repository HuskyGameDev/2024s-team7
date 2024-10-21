extends VBoxContainer

signal selected_item(id)

@onready var id = self.get_meta("ID")
@onready var sprite = $SpriteContainer/Sprite2D
@onready var button = $Button
@onready var equip_screen = get_node("/root/EquipScreen")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	equip_screen.connect("reload", on_reload)
	on_reload()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("selected_item", id)

func on_reload() -> void:
	id = self.get_meta("ID")
	print(id)
	if (ItemStorage.itemsList[id].owned == true && ItemStorage.itemsList[id].equipped == true):
		sprite.visible = true
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/Shop_sprites.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]
		button.visible = true
	else:
		sprite.visible = false
		button.visible = false
