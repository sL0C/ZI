extends KinematicBody2D

# Declare member variables here. Examples:
var health = 100
var target = null
var target_Position = null
onready var direction
export var speed = 50
var damage = 50
onready var raycast = $RayCast2D
var timer
var x = 0
var y = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("walking_speed")
	$AnimationPlayer.connect("animation_finished", self, "animation_player_finished")
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(5)
	print("start")
	print(!timer.is_stopped())
	direction = set_random_direction()
	pass # Replace with function body.
	
	
func animation_player_finished(animation):
	if animation == "walking_speed":
		$AnimationPlayer.play("walking_speed")
	elif animation == "attacking":
		$AnimationPlayer.play("walking_speed")
		
		
func set_random_direction():
	if !timer.is_stopped():
		return Vector2(x,y)
	else:
		randomize()
		x = randi()%3-1
		y = randi()%3-1
		timer.start(5)
		return Vector2(x,y)
		
		
func is_close_to_position(t_Pos):
	if is_close_to(position.x, t_Pos.x):
		if is_close_to(position.y, t_Pos.y):
			return true
	pass
	
	
func is_close_to(first, second):
	if first - 10 < second && first + 10 > second:
		return true
	pass


func _physics_process(delta):
	if target == null:
		if target_Position == null:
			if direction != null && speed != null:
				direction = set_random_direction()
		else:
			if is_close_to_position(target_Position):
				set_random_direction()
				target_Position = null
			else:
				direction = position.direction_to(target_Position)
	else:
		var bodies = $listening_area.get_overlapping_bodies()
		for body in bodies:
			if body == target:
				direction = position.direction_to(target.position)
				raycast_look_at_and_collide(direction)
				move_and_collide(direction * speed * delta)
				return
			target = null
	raycast_look_at_and_collide(direction)
	move_and_collide(direction * speed * delta)
		#check if player still in sight if not replace with target_position
		

func raycast_look_at_and_collide(direction):
	raycast.look_at(position + direction)
	raycast.enabled = true
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("player"):
			if !$AnimationPlayer.current_animation == "attacking":
				$AnimationPlayer.play("attacking")
	pass


func move(vec):
	move_and_slide(vec)
	pass


func attacking():
	print("attacking")
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("player"):
			collider.take_damage(damage)
	pass


func take_damage(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
	pass


func _on_listening_area_area_entered(area):
	if area.is_in_group("sound"):#group:playerMadeSound?
		if area.get_cause_Object().is_in_group("player"):
			var bodies = $listening_area.get_overlapping_bodies()
			for body in bodies:
				if body.is_in_group("player"):
					target = body
					print(target)
					return
			target_Position = area.get_cause_Object().position
	pass