extends Node


const OPTIONS_PATH := "user://config/options.json"


@warning_ignore("unused_signal")
signal options_updated


var options := {
	# Video
	"resolution": -1
}


func _ready() -> void:
	load_options()


func load_options() -> void:
	var file = FileAccess.open(OPTIONS_PATH, FileAccess.READ)
	if !file:
		push_error("Could not open file (%s)" % [OPTIONS_PATH])
		return
	var json_str := file.get_as_text()
	
	file.close()
	
	options = JSON.parse_string(json_str)
	options_updated.emit()


func save_options() -> void:
	var json_str := JSON.stringify(options)
	
	if !DirAccess.dir_exists_absolute(OPTIONS_PATH.get_base_dir()):
		print("making: '%s'" % [OPTIONS_PATH.get_base_dir()])
		DirAccess.make_dir_recursive_absolute(OPTIONS_PATH.get_base_dir())
	var file := FileAccess.open(OPTIONS_PATH, FileAccess.WRITE)
	if !file:
		push_error("Could not open file (%s)" % [OPTIONS_PATH])
		return
	file.store_line(json_str)
	file.close()


func new_unit(id: String) -> Unit:
	var file = id + ".tscn"
	var scene : PackedScene = load("res://units/nodes/" + file)
	if !scene: push_error("Could not load scene (%s)" % [file]); return null
	var node : Unit = scene.instantiate()
	return node
