extends KinematicBody2D

#TODO replace with var pickup_item = preload("res://scenes/m_sword.tscn")
var pickup_item = preload("res://scenes/m_sword.tscn")

func _ready():
	pass


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