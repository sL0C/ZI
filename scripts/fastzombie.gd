extends KinematicBody2D

# Declare member variables here. Examples:
export var speed = 100
var health = 150
var target = null
var target_Position = null
var damage = 50
var timer
var x = 0
var y = 1
onready var direction
onready var raycast = $RayCast2D

func _ready():
	$AnimationPlayer.play("walking_speed")
	$AnimationPlayer.connect("animation_finished", self, "animation_player_finished")
	timer = Timer.new()
	add_child(timer)
	timer.start(5)
	direction = set_random_direction()
	pass
	
	
func animation_player_finished(animation):
	if animation == "walking_speed":
		$AnimationPlayer.play("walking_speed")
	elif animation == "charge":
		if check_if_target_is_in_range():
			$AnimationPlayer.play("charge")
		else:
			$AnimationPlayer.play("walking_speed")
	elif animation == "attacking":
		$AnimationPlayer.play("walking_speed")
		
		
func set_random_direction():
	if !timer.is_stopped():
		return Vector2(x,y)
	else:
		timer.start(5)
		randomize()
		x = randi()%3-1
		y = randi()%3-1
		return Vector2(x,y)
		
		
func check_if_target_is_in_range():
	var bodies = $listening_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			return true
	pass
	
	
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
				$AnimationPlayer.play("charge")
	else:
		var bodies = $listening_area.get_overlapping_bodies()
		for body in bodies:
			if body == target:
				direction = position.direction_to(target.position)
				if $AnimationPlayer.is_playing() and !$AnimationPlayer.current_animation == "attacking":
					$AnimationPlayer.play("charge")
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
					return
			target_Position = area.get_cause_Object().position
	pass