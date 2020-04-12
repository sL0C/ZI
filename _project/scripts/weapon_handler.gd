extends Node

var weapons = [load("res://scenes/m_fists.tscn"), load("res://scenes/m_stone.tscn")]
var last_Ammunition = []
var current_Weapon = 0
#add environment to add thrown weapons to
onready var environment = self.get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, weapons.size()):
		if weapons[i] != null:
			var weapon = weapons[i].instance()
			last_Ammunition.append(weapon.ammunition)
	add_child(weapons[0].instance())
	switch_weapon(0)
	pass # Replace with function body.
	
	
func get_weapon_n_by_identifier(identifier):
	for i in range(0, weapons.size()):
		if weapons[i] != null:
			if weapons[i].instance().identifier == identifier:
				return i
	pass


func switch_weapon(n):
	#Cancel if switching to empty slot
	if weapons[n] == null:
		return
	#var number = get_weapon_n_by_identifier(get_child(0).identifier)
	#if weapons[number].instance().identifier != get_child(0).identifier:
	#if number == n:
	#	return#return if switching to the equiped gun 
	#Cancel if switching to current weapon 
	if current_Weapon == n:
		return	
	#set ammunition backup of current weapon to current weapons ammunition
	last_Ammunition[current_Weapon] = get_child(0).ammunition
	current_Weapon = n
	
	var looked_at_vector = get_child(0).get_last_looked_at_vector()
	#delete and add new child
	get_child(0).queue_free()
	add_child(weapons[current_Weapon].instance())
	raycast_look_at(looked_at_vector)
	get_child(0).ammunition = last_Ammunition[current_Weapon]
	#if weapons[n].instance().identifier == get_child(0).identifier:
	#	print(true)
	#	last_Ammunition[n] = get_child(0).ammunition
	print("lastamu: ", last_Ammunition)
	#get_child(0).bullets_when_ready = last_Ammunition
	#print("ttt ",get_child(0).bullets_when_ready)
	print(get_child(0).ammunition)
	pass
	
	
func add_item(item):
	#give weapon ready to throw //return the throwable/pickupable weapon object
	#var w = weapons[current_Weapon].get_instance_of_pickable_item()
	var w = get_child(0).get_pickable_item_scene()
	#add current ammunition to weapon
	last_Ammunition[current_Weapon] = get_child(0).ammunition
	#w.instance()
	if w != null:
		environment.add_child(w)
		w.ammunition = last_Ammunition[current_Weapon]
	#equip new weapon and add its ammunition into ammunition array
	weapons[current_Weapon] = item
	last_Ammunition[current_Weapon] = weapons[current_Weapon].instance().ammunition
	#delete old and switch to new weapon
	get_child(0).queue_free()
	add_child(weapons[current_Weapon].instance())
	#TODO: throw w into environment
	#TODO How to:
	# instance pickupable weapon object, add ammunition from old weapon instance
	#Search where new ammunition is added, add that new ammunition is taken from ammunition of object
	return w
	pass


func shoot():
	get_child(0).shoot()
	pass


func reload():
	get_child(0).reload()
	pass


func raycast_look_at(global_mouse_position):
	get_child(0).raycast_look_at(global_mouse_position)
	pass