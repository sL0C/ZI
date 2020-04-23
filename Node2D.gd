extends Area2D

var direction

func _ready():
	print("node2d")
	set_direction()
	execute_postion()
	pass


func set_direction():
	direction = (get_global_mouse_position() - get_parent().position).normalized()
	pass
	
	
func execute_postion():
	position = position + (direction*50)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
