class_name Structure
extends Unit


@export var bounds : Shape3D

var bounds_area : Area3D


func _ready() -> void:
	if bounds:
		bounds_area = Area3D.new()
		var bounds_col_node := CollisionShape3D.new()
		bounds_col_node.shape = bounds
		bounds_area.add_child(bounds_col_node)
		add_child(bounds_area)
