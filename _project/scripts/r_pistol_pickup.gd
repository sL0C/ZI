extends Area2D

var pickup_item = preload("res://scenes/r_pistol.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func pickup():
	#change picture
	#return the item its carrying
	return pickup_item
	pass
	
	
func add_item(item):
	pickup_item = item
	#change picture
	pass
	
	
func take_damage(dmg):
	#play sound
	pass