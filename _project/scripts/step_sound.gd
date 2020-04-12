extends Area2D

var cause_Object

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", self, "timeout")
	$Timer.start(0.5)
	set_size(2)
	pass # Replace with function body.

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass