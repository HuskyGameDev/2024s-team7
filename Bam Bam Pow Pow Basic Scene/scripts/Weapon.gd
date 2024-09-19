## This is a general class to create a weapon in the game.
class_name Weapon

## The name of the weapon.
var name: String

## The damage type the weapon deals.
var damage_type: String

## All of the attacks a weapon has.
var light_up: Attack
var light_down: Attack
var light_side: Attack
var light_air: Attack
var heavy_up: Attack
var heavy_down: Attack
var heavy_side: Attack
var heavy_air: Attack

## Initializes a weapon.
##
## Parameters:
## String	path: This is the path to the JSON file containing the specifcations
## of the weapon. It has a default value of the template JSON file.
##
## Returns:
## void: This is a constructor, it does not return.
func _init(path: String="res://resources/weapons/template.json") -> void:
	var json = get_json(path)
	self.name = json["name"]
	self.damage_type = json["damage_type"]
	
	var data = json["light_up"]
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
	data = json["heavy_up"]
	self.light_up = Attack.new(data["damage"], data["knockback"], 
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
## Dictionary: This is the data for the weapon.
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
