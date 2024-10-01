## This is a general class to create a weapon in the game.
class_name Weapon

## The name of the self.
var name: String

## The damage type the weapon deals.
var damage_type: String

## All of the attacks a weapon has.
var light_neutral: Attack
var light_up: Attack
var light_down: Attack
var light_side: Attack
var light_air: Attack
var heavy_neutral: Attack
var heavy_up: Attack
var heavy_down: Attack
var heavy_side: Attack
var heavy_air: Attack

## Initializes a self.
##
## Parameters:
## path		String: This is the name of the JSON file containing the
## specifcationsof the self. It has a default value of the template JSON 
## file.
##
## Returns:
## void: This is a constructor, it does not return.
func _init(path: String="template") -> void:
	path = "res://resources/weapons/" + path + ".json"
	var json = get_json(path)
	self.name = json["name"]
	self.damage_type = json["damage_type"]
	
	var data = json["light_neutral"]
	self.light_neutral = Attack.new(data["damage"], data["knockback"], 
							   data["angle"], data["hit_stun"], 
							   self.damage_type, data["animation"])
	data = json["light_up"]
	self.light_up = Attack.new(data["damage"], data["knockback"], 
								 data["angle"], data["hit_stun"], 
								 self.damage_type, data["animation"])
	data = json["light_down"]
	self.light_down = Attack.new(data["damage"], data["knockback"], 
								 data["angle"], data["hit_stun"], 
								 self.damage_type, data["animation"])
	data = json["light_side"]
	self.light_side = Attack.new(data["damage"], data["knockback"], 
								 data["angle"], data["hit_stun"], 
								 self.damage_type, data["animation"])
	data = json["light_air"]
	self.light_air = Attack.new(data["damage"], data["knockback"], 
								data["angle"], data["hit_stun"], 
								self.damage_type, data["animation"])
	data = json["heavy_neutral"]
	self.heavy_neutral = Attack.new(data["damage"], data["knockback"], 
							   		data["angle"], data["hit_stun"], 
							   		self.damage_type, data["animation"])
	data = json["heavy_up"]
	self.heavy_up = Attack.new(data["damage"], data["knockback"], 
							   data["angle"], data["hit_stun"], 
							   self.damage_type, data["animation"])
	data = json["heavy_down"]
	self.heavy_down = Attack.new(data["damage"], data["knockback"], 
								 data["angle"], data["hit_stun"], 
								 self.damage_type, data["animation"])
	data = json["heavy_side"]
	self.heavy_side = Attack.new(data["damage"], data["knockback"], 
								 data["angle"], data["hit_stun"], 
								 self.damage_type, data["animation"])
	data = json["heavy_air"]
	self.heavy_air = Attack.new(data["damage"], data["knockback"], 
								data["angle"], data["hit_stun"], 
								self.damage_type, data["animation"])


## Check to see if the JSON file exists, if so then retrieve its data.
##
## Parameters:
## String	path: The path to the JSON file.
##
## Returns:
## Dictionary: This is the data for the self.
func get_json(path: String) -> Dictionary:
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if data is Dictionary:
			return data
		else:
			printerr("Error reading from file.")
			return {}
		
	else:
		printerr("Weapon file does not exist.")
		return {}
	
func print_weapon():
	print("Weapon Name:" + self.name)
	print(" Light Neutral:")
	self.light_neutral.print_attack()
	print(" Light Up:")
	self.light_up.print_attack()
	print(" Light Down:")
	self.light_down.print_attack()
	print(" Light Side:")
	self.light_side.print_attack()
	print(" Light Air:")
	self.light_air.print_attack()
	print(" Heavy Neutral:")
	self.heavy_neutral.print_attack()
	print(" Heavy Up:")
	self.heavy_up.print_attack()
	print(" Heavy Down:")
	self.heavy_down.print_attack()
	print(" Heavy Side:")
	self.heavy_side.print_attack()
	print(" Heavy Air:")
	self.heavy_air.print_attack()
