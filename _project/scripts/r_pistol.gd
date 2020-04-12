extends Node


var full_Ammunition = 12
var damage = 200
var ammunition = 6
var reloading = false
var identifier = "pistol"
var lastLookedAtVector = Vector2()
var time_until_ready = 1
var ready_Timer
var ready = false
var pickable_item = load("res://scenes/r_pistol_pickup.tscn")
onready var bullets_when_ready = load_ready_bullets()
onready var raycast = $RayCast2D
onready var reload_Timer = $Timer

# Called when the node enters the scene tree for the first time.
func load_ready_bullets():
	var n = get_parent().get_weapon_n_by_identifier(identifier)
	return get_parent().last_Ammunition[n]
	pass
	
	
func _ready():
	reload_Timer.connect("timeout", self, "on_reload_timer_timeout")
	reload_Timer.one_shot = true
	ready_Timer = Timer.new()
	ready_Timer.connect("timeout",self,"_on_ready_timer_timeout")
	ready_Timer.one_shot = true
	add_child(ready_Timer)
	ready_Timer.start(time_until_ready)
	pass
	

func _on_ready_timer_timeout():
	ammunition = bullets_when_ready
	ready = true
	pass


func raycast_look_at(vec):
	raycast.look_at(vec)
	lastLookedAtVector = vec
	pass


func get_last_looked_at_vector():
	return lastLookedAtVector


func shoot():
	print("shoot")
	if ammunition == null:
		print("ammu = null")
		return
	if (ammunition > 0) && (!reloading) && (ready):
		print("ammuntion check true")
		if raycast.is_colliding():
			print("is colliding")
			var collider = raycast.get_collider()
			print(collider)
			#if !(collider.is_in_group("player") || collider.is_in_group("friendly npc")):
			if collider.is_in_group("enemy"):
				collider.take_damage(damage)
				print("coll take damage")
		#play sound
		#start screenshake
		ammunition -= 1
		print(ammunition)
	else:
		if !reloading && ready_Timer.is_stopped():
			reload()


func reload():
	reloading = true
	reload_Timer.start(2)
	print("reloading")
	pass


func on_reload_timer_timeout():
	ammunition = full_Ammunition
	reloading = false
	print(ammunition)
	pass


func get_pickable_item_scene():
	return pickable_item
	pass