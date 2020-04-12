extends Node2D

var full_Ammunition = 1
var damage = 100
var ammunition = 1
var identifier = "fist"
var lastLookedAtVector = Vector2()
var can_shoot_again = false
var can_shoot_again_timer
var fist = load("res://scenes/fist.tscn")
#doesnt exist but is as template
#var pickupable_item_path = load("res://scenes/fist_pickable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func shoot():
	print("shoot")
	var global_mouse_pos = get_global_mouse_position()
	var f = fist.instance()
	f.set_direction(global_mouse_pos, get_parent().global_position)
	add_child(f)
	f.execute_postion()
	var player = get_parent().get_parent()
	if player.is_in_group("player"):
		player.stand_for(0.3)
	pass


func reload():
	pass


func get_last_looked_at_vector():
	return lastLookedAtVector


func raycast_look_at(vec):
	$RayCast2D.look_at(vec)
	lastLookedAtVector = vec
	pass


func get_pickable_item_scene():
	return null
	#use on other weapons:
	#return pickable_item