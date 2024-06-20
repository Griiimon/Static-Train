extends Node3D

@export var train_counter_force: float= 100.0

@onready var ground: Ground = $Ground
@onready var train: Train = $Train
@onready var moving_ground: StaticBody3D = $"StaticBody Moving Ground"

@onready var outside_world: World3D= $SubViewport.world_3d

var rigidbodies: Array[MyRigidbody]


func _process(delta):
	ground.move(train.speed * Vector3.DOWN)


func _physics_process(delta):
	for rb in rigidbodies:
		if rb.is_touching_train:
			rb.apply_central_force(-train.acceleration * train_counter_force)
		elif rb.is_ghost:
			rb.global_transform= rb.original.global_transform.translated(-train.virtual_position)


func _on_train_simulation_area_body_exited(body):
	if body is RigidBody3D:
		var ghost: MyRigidbody= body.duplicate()
		ghost.is_ghost= true
		ghost.original= body
		body.reparent($SubViewport)
		body.move_to_offset= train.virtual_position
		body.linear_velocity+= train.speed * Vector3.FORWARD
		add_child(ghost)
