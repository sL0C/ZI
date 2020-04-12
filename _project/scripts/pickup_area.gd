extends Area2D

var direction
onready var timer = $Timer
signal timeout
signal _on_pickup_area_body_entered

func set_direction(mouse_pos,start_pos):
	direction = (mouse_pos - start_pos).normalized()
	execute_postion()
	pass
	
	
func execute_postion():
	position = position + (direction * 15)
	pass


func _ready():
	timer.connect("timeout", self, "timeout")
	timer.start()
	pass


func timeout():
	position = Vector2(0,0)
	emit_signal("timeout")
	self.queue_free()
	pass


func _on_pickup_area_body_entered(body):
	if body.is_in_group("pickup"):
		emit_signal("_on_pickup_area_body_entered", body)
		return body
	pass