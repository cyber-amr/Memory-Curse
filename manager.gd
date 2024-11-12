extends Node


@warning_ignore("unused_signal")
signal options_updated


var options := {
	"resolution": 1.0
}


func new_unit(id: String) -> Unit:
	var file = id + ".tscn"
	var scene : PackedScene = load("res://units/nodes/" + file)
	if !scene: push_error("Could not load scene (%s)" % [file]); return null
	var node : Unit = scene.instantiate()
	return node
