extends MeshInstance3D
class_name Ground

@export var texture_scroll_div: float= 50000.0


func move(vec: Vector3):
	mesh.material.uv1_offset+= vec / texture_scroll_div
