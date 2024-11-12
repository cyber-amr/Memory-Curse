extends Node


func new_unit(id: String) -> Unit:
	var file = id + ".tscn"
	var scene : PackedScene = load("res://units/nodes/" + id)
	var node : Unit = scene.instantiate()
	return node
