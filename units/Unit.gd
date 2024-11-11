class_name Unit
extends CharacterBody3D


@export var shape : Shape3D
@export var mesh : Mesh

@export var cost : int = 100
@export var health : int = 100


func _ready() -> void:
	if shape:
		var col_node = CollisionShape3D.new()
		col_node.shape = shape
		add_child(col_node)
	
	if mesh:
		var mesh_node = MeshInstance3D.new()
		mesh_node.mesh = mesh
		add_child(mesh_node)
	
