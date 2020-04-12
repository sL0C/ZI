extends KinematicBody2D

#TODO replace with var pickup_item = preload("res://scenes/m_sword.tscn")
var pickup_item = preload("res://scenes/m_sword.tscn")

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
