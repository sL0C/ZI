extends Node2D

onready var raycast = $RayCast2D
onready var reload_Timer = $Timer
var full_Ammunition = 1
var damage = 150
var ammunition = 1
var identifier = "stone"
var lastLookedAtVector = Vector2()
var can_shoot_again = false
var can_shoot_again_timer
var pickupable_item_path = load("res://scenes/stone_pickable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot_again_timer = $Timer
	can_shoot_again_timer.one_shot = true
	can_shoot_again_timer.connect("timeout",self,"_on_can_shoot_again_timer_timeout")
	if can_shoot_again_timer.is_stopped():
		can_shoot_again_timer.start(0.2)
	pass # Replace with function body.
func _on_can_shoot_again_timer_timeout():
	can_shoot_again = true
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
	if can_shoot_again:
		print("ammunition check true")
		if raycast.is_colliding():
			print("is colliding")
			var collider = raycast.get_collider()
			print(collider)
			if !(collider.is_in_group("player") || collider.is_in_group("friendly npc")):
				collider.take_damage(damage)
				print("coll take damage")
		#play sound
		#start screenshake
		if can_shoot_again_timer.is_stopped():
			can_shoot_again_timer.start(0.2)
			can_shoot_again = false
			print("richtig")
		print("can_shoot_again", false)
		print(ammunition)
		
func reload():
	pass
	
func get_pickable_item_scene():
	pass
