extends Area2D

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	print("node2d")
	set_direction()
	execute_postion()
	pass # Replace with function body.


func set_direction():
	direction = (get_global_mouse_position() - get_parent().position).normalized()
	pass
	
	
func execute_postion():
	position = position + (direction*50)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
