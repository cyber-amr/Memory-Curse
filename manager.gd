extends Node


const OPTIONS_PATH := "user://config/options.json"


@warning_ignore("unused_signal")
signal options_updated


var options := get_default_options()
var game : Game


func _ready() -> void:
	options_updated.connect(apply_options)
	if !load_options():
		apply_options()


func load_options() -> int:
	var file = FileAccess.open(OPTIONS_PATH, FileAccess.READ)
	if !file:
		push_error("Could not open file (%s)" % [OPTIONS_PATH])
		return ERR_FILE_CANT_OPEN
	var json_str := file.get_as_text()
	
	file.close()
	
	var dict : Dictionary = JSON.parse_string(json_str)
	for k in dict.keys():
		options[k] = dict[k]
	options_updated.emit()
	return OK


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


func reset_options() -> void:
	options = get_default_options()
	options_updated.emit()
	
	DirAccess.remove_absolute(OPTIONS_PATH)


func apply_options():
	OS.low_processor_usage_mode = options["power_saving"]
	get_window().set_mode(Window.MODE_FULLSCREEN if options["fullscreen"] else Window.MODE_WINDOWED)


func get_default_options() -> Dictionary:
	var dict := {
		# Controls
		"enable_damping": true,
		"zoom_speed": 1,
		"sensitivity": 1,
		"rotate_speed": 1,
		"camera_speed": 1,
		# Video
		"resolution": -1,
		"power_saving": false,
		"fullscreen": true
	}
	return dict


func new_unit(id: String) -> Unit:
	var file = id + ".tscn"
	var scene : PackedScene = load("res://units/nodes/" + file)
	if !scene: push_error("Could not load scene (%s)" % [file]); return null
	var node : Unit = scene.instantiate()
	return node
