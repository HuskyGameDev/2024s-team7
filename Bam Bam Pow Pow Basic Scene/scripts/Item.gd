extends VBoxContainer

signal bought_item(money) # Signal for when the item is bought that uses its money stat

# Finds the items label for its cost, its buy button, its sprite in the scene, the node for its id, 
# the purchase noise, its ID from its ID node, and its audio player
@onready var item_shop = get_node("/root/ItemShop")
@onready var money_label = $HBoxContainer/PriceLabel
@onready var buy_button = $HBoxContainer/BuyButton
@onready var sprite = $SpriteContainer/Sprite2D
@onready var name_label = $NameLabel
@onready var purchase_noise = preload("res://resources/sounds/Item_Purchase_Coins.wav")
@onready var id = self.get_meta("ID")
@onready var con = get_node("/root/ItemShop/Control")
@onready var audioPlayer = get_node("/root/ItemShop/AudioStreamPlayer")

var money # The cost of the item

# Called when the node enters the scene tree for the first time.
func _ready():
	item_shop.connect("reload", _on_item_shop_reload)
	item_shop.connect("bought_item", _on_button_pressed)
	_on_item_shop_reload() # Reloads the items sprite and labels

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Function to call when reloading the items characteristics in the shop
func _on_item_shop_reload():
	id = self.get_meta("ID") # Updates the id variable here based on what the metadata was changed to
	var lessThanMax = (id < ItemStorage.itemMax)
	if (lessThanMax == false):
		money_label.visible = false
		buy_button.visible = false
		sprite.visible = false
		name_label.visible = false
	elif (ItemStorage.itemsList[id].owned == true):
		money_label.visible = false
		buy_button.visible = false
		sprite.visible = true;
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/Shop_sprites.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]
		name_label.visible = true
		name_label.text = "Bought"
	else: # If the item is not owned by the player
		# Make the label for the cost, buy button, and sprite visible
		money_label.visible = true
		buy_button.visible = true
		sprite.visible = true
		name_label.visible = true
		# Updates the cost of the item to match the item's info in the item list, then updates its price
		# label to be accurate and the sprite to be its sprite
		money = ItemStorage.itemsList[id]["price"]
		money_label.text = "Price: " + str(ItemStorage.itemsList[id]["price"])
		name_label.text = ItemStorage.itemsList[id]["name"]
		if (ItemStorage.itemsList[id]["sprite"] != null):
			sprite.texture = load("res://resources/sprites/Shop_sprites.png")
			sprite.frame = ItemStorage.itemsList[id]["sprite"]

# When the button attatched to the item is pressed
func _on_button_pressed():
	if ItemStorage.money >= money:
		# Makes the item no longer visible or interactable
		ItemStorage.itemsList[id]["owned"] = true # Updates the item to be owned by the player in the item storage
		ItemStorage.owned_items.append(ItemStorage.itemsList[id])
		_on_item_shop_reload()
		#Plays the purchase noise
		if (!audioPlayer.is_playing()):
			audioPlayer.stream = purchase_noise
			audioPlayer.play()
		emit_signal("bought_item", money) # Emits the signal to say the item was bought with the appropriate cost
