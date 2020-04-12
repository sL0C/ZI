extends Area2D

var direction
var full_Ammunition = 1
var damage = 100
var ammunition = 1
var identifier = "fist"
var lastLookedAtVector = Vector2()
var can_shoot_again = false
onready var can_shoot_again_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot_again_timer.connect("timeout", self, "timeout")
	pass # Replace with function body.


func timeout():
	self.queue_free()
	pass


func set_direction(mouse_pos,start_pos):
	direction = (mouse_pos - start_pos).normalized()
	pass


func execute_postion():
	#print("executing")
	position = position + (direction * 15)
	#overlapping bodies returns [] so it has been changed to the signal "on fist body entered"
	#var bodies = get_overlapping_bodies()
	#print(bodies)
	#for body in bodies:
	#	print(bodies)
	#	if !(body.is_in_group("player") || body.is_in_group("friendly npc")):
	#		body.take_damage(damage)
	pass


func _on_fist_body_entered(body):
	print(body)
	if !(body.is_in_group("player") || body.is_in_group("friendly npc" )):
		body.take_damage(damage)
	pass # Replace with function body.
