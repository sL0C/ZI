extends RayCast2D

export var attack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if attack:
		attack = false
		get_parent().attacking()
	pass

