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
	#New Implementation of fighting melee
	#charge in direction of attack
	#move in direction with high speed
	#compare targets hit by weapons hitbox to targets hit with player hitbox(provided by get_parent())
	#deal damage to those hit, take from those that hit you
	#to deal with problem of standing still in time of fighting
	if true:
		#spawn hitbox -> add hit objects to hit array
		#add hit characters to array
		#if there has been a hit in hitbox, ignore hit characters
		#deal damage (to all hit, to self by hit character if nobody was hit by attackbox)
		#returns spawned hitbox
		var attack_hitbox = get_child(0).spawn_attack_hitbox()
		var player_hitbox = get_parent().get_hitbox()
		attack_hitbox.connect("_on_body_entered", self, "_on_body_entered_attack_hitbox")
		player_hitbox.connect("_on_body_entered", self, "_on_body_entered_player_hitbox")
		get_parent().get_node("AnimationPlayer").play("attack")
		get_parent().move_in_mouse_direction()
		#disable attacking while in move
		return
	get_child(0).shoot()
	pass

func get_multiplier():
	#return get_child(0).multiplier
	return 1
	pass

func resolve_attack():
	get_parent().set_collision()
	#enable attacking
	if attack_hitbox_collisions.size() < 1:
		#deal damage to player
		return
	else:
		for hitbox in attack_hitbox_collisions:
			return
			#hitbox.deal_damage(get_child(0).get_damage)
	pass
	
var attack_hitbox_collisions = []
func _on_body_entered_attack_hitbox(body):
	attack_hitbox_collisions.append(body)
	pass
	
var player_hitbox_collisions = []
func _on_body_entered_player_hitbox(body):
	player_hitbox_collisions.append(body)
	pass

func reload():
	get_child(0).reload()
	pass


func raycast_look_at(global_mouse_position):
	get_child(0).raycast_look_at(global_mouse_position)
	pass