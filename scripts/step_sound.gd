extends Area2D

var cause_Object

func _ready():
	$Timer.connect("timeout", self, "timeout")
	$Timer.start(0.5)
	set_size(2)
	pass

func set_size(n):
	$CollisionShape2D.set("scale", n)
	pass


func timeout():
	self.queue_free()
	pass
	
	
func get_position():
	return position
	
	
func set_cause_Object(bod):
	cause_Object = bod
	
	
func get_cause_Object():
	return cause_Object