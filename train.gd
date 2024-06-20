extends Node3D
class_name Train

@export var run: bool= true
@export var speed_curve: Curve

var speed: float
var prev_speed: float
var acceleration: Vector3
var virtual_position:= Vector3.ZERO


func _physics_process(delta):
	if not run: return
	
	if speed_curve:
		speed= speed_curve.sample(Engine.get_physics_frames() / 6000.0)
	else:
		if Input.is_key_pressed(KEY_PAGEUP):
			speed+= delta
		elif Input.is_key_pressed(KEY_PAGEDOWN):
			speed-= delta
	
	virtual_position+= Vector3.FORWARD * speed * delta
	acceleration= Vector3.FORWARD * (speed - prev_speed)
	prev_speed= speed
	
