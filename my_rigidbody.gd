class_name MyRigidbody
extends RigidBody3D


var is_touching_train: bool= false
var is_ghost: bool= false:
	set(b):
		is_ghost= b
		if is_ghost:
			freeze= true
			for child in find_children("", "CollisionShape3D"):
				child.queue_free()
			
var original: MyRigidbody
var move_to_offset: Vector3



func _ready():
	if not get_parent().is_inside_tree():
		await get_parent().ready
	get_parent().rigidbodies.append(self)


func _integrate_forces(state):
	is_touching_train= false
	for idx in state.get_contact_count():
		if state.get_contact_collider_object(idx).collision_layer == 8:
			is_touching_train= true
			break
	
	if move_to_offset:
		state.transform= state.transform.translated(move_to_offset)
		move_to_offset= Vector3.ZERO
