extends Area2D

var direction
var full_Ammunition = 1
var damage = 100
var ammunition = 1
var identifier = "fist"
var lastLookedAtVector = Vector2()
var can_shoot_again = false
onready var can_shoot_again_timer = $Timer

func _ready():
	can_shoot_again_timer.connect("timeout", self, "timeout")
	pass


func timeout():
	self.queue_free()
	pass


func set_direction(mouse_pos,start_pos):
	direction = (mouse_pos - start_pos).normalized()
	rotate(atan2(direction.y, direction.x))
	pass


func execute_postion():
	position = position + (direction * 15)
	pass


func _on_fist_body_entered(body):
	print(body)
	if !(body.is_in_group("player") || body.is_in_group("friendly npc" )):
		body.take_damage(damage)
	pass
