extends KinematicBody2D

export var multiplier_animation = 0
const MAX_SPEED = 250
const ACCELERATION = 50
var move_vec = Vector2()
var friction_x = false
var friction_y = false
var step_Timer
var health = 200
var standing = true
var standing_locked = false
var stand_Timer
var pickup_area = load("res://scenes/pickup_area.tscn")
var p_a
onready var step = preload("res://scenes/step_sound.tscn")

#For new launching attack
func get_hitbox():
	$CollisionShape2D.disabled = true
	$hitbox/CollisionShape2D.disabled = false
	return $hitbox
	#spawn hitbox
	pass
func set_collision():
	$CollisionShape2D.disabled = false
	$hitbox/CollisionShape2D.disabled = true
	return $hitbox
	#spawn hitbox
	pass

func move_in_mouse_direction():
	print("moving_in_mouse_dir")
	var mouse_pos = get_global_mouse_position()
	var start_pos = global_position
	var direction = (mouse_pos - start_pos).normalized()
	var move_vec = direction * multiplier_animation * $weapon_handler.get_multiplier()
	move_and_collide(move_vec)
	start_pos = Vector2(0,0)
	direction = Vector2(0,0)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	step_Timer = $Timer
	step_Timer.connect("timeout",self,"_on_step_Timer_timeout")
	set_physics_process(true)
	stand_Timer = $stand_Timer
	stand_Timer.one_shot = true
	stand_Timer.connect("timeout",self,"release_stand")
	pass # Replace with function body.


func take_damage(dmg):
	health -= dmg
	if health < 1:
		queue_free()


func _on_step_Timer_timeout():
	var s = step.instance()
	s.set_cause_Object(self)
	s.position = self.position
	get_parent().add_child(s)
	pass
	
	
func release_stand():
	standing_locked = false
	print("released")
	pass


func stand_for(time):
	if time < 0:
		standing_locked = true
		if !standing:
			standing = true
	else:
		stand_Timer.start(time)
		standing_locked = true
		standing = true
	pass


func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		move_vec.y = max(move_vec.y-ACCELERATION, -MAX_SPEED)
		friction_y = false
		if step_Timer.is_stopped():
			step_Timer.start()
	if Input.is_action_pressed("move_down"):
		move_vec.y = min(move_vec.y+ACCELERATION, MAX_SPEED)
		friction_y = false
		if step_Timer.is_stopped():
			step_Timer.start()
	if Input.is_action_pressed("move_left"):
		move_vec.x = max(move_vec.x-ACCELERATION, -MAX_SPEED)
		friction_x = false
		if step_Timer.is_stopped():
			step_Timer.start()
	if Input.is_action_pressed("move_right"):# if step timer is not running start 
		move_vec.x = min(move_vec.x+ACCELERATION, MAX_SPEED)
		friction_x = false
		if step_Timer.is_stopped():
			step_Timer.start()
	if Input.is_action_just_released("move_up"):
		friction_y = true
		if !step_Timer.is_stopped():
			step_Timer.stop()
	if Input.is_action_just_released("move_down"):
		friction_y = true
		if !step_Timer.is_stopped():
			step_Timer.stop()
	if Input.is_action_just_released("move_left"):
		friction_x = true
		if !step_Timer.is_stopped():
			step_Timer.stop()
	if Input.is_action_just_released("move_right"):
		friction_x = true
		if !step_Timer.is_stopped():
			step_Timer.stop()
	if Input.is_action_just_pressed("shoot"):
		$weapon_handler.shoot()
	if Input.is_action_pressed("pickup"):
		if p_a == null:
			var global_mouse_pos = get_global_mouse_position()
			p_a = pickup_area.instance()
			p_a.set_direction(global_mouse_pos, global_position)
			p_a.connect("_on_pickup_area_body_entered", self, "pickup")
			p_a.connect("timeout", self, "timeout_p_a")
			add_child(p_a)
	#!no else lerp because standing should be instant also bc is weird if multiple ifs need to be activated at the same time
	#move_vec = move_vec.normalized() no normalization to enable diagonal speedrunning
	if friction_x:#if step timer is running stop
		move_vec.x = lerp(move_vec.x, 0, 0.2)
	if friction_y:
		move_vec.y = lerp(move_vec.y, 0, 0.2)
	if !standing_locked:
		standing = false
		if Input.is_action_pressed("sneak"):
			step_Timer.stop()
			move_vec = move_vec / 2
		move_and_collide(move_vec * delta)
	else:
		if !step_Timer.is_stopped():
			step_Timer.stop()
		standing = true
	
	if Input.is_action_just_pressed("switch_w_1"):
		$weapon_handler.switch_weapon(0)
	if Input.is_action_just_pressed("switch_w_2"):
		$weapon_handler.switch_weapon(1)
	if Input.is_action_just_pressed("reload"):
		$weapon_handler.reload()
	$weapon_handler.raycast_look_at(direction_to(get_global_mouse_position()))


func timeout_p_a():
	print("pa = null")
	p_a = null
	pass


func pickup(body):
	var old_weapon = $weapon_handler.add_item(body.pickup())
	p_a.queue_free()
	
	
func move(vec):
	move_and_slide(vec)
	pass