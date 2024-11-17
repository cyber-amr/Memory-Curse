extends Node


func _ready() -> void:
	update()
	Manager.options_updated.connect(update)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		back()


func back():
	Manager.save_options()
	queue_free()


func reset():
	Manager.reset_options()


func update():
	# Controls
	$"%ZoomSpeed".value = Manager.options["zoom_speed"]
	$"%RotateSpeed".value = Manager.options["rotate_speed"]
	$"%CameraSpeed".value = Manager.options["camera_speed"]
	$"%Sensitivity".value = Manager.options["sensitivity"]
	$"%EnableDamping".button_pressed = Manager.options["enable_damping"]

	# Video
	$"%ResolutionSlider".value = Manager.options["resolution"]
	$"%PowerSaving".button_pressed = Manager.options["power_saving"]
	$"%FullScreen".button_pressed = Manager.options["fullscreen"]


# Controls
func change_zoom_speed(value: float) -> void:
	Manager.options["zoom_speed"] = value
	Manager.options_updated.emit()


func change_sensitivity(value: float) -> void:
	Manager.options["sensitivity"] = value
	Manager.options_updated.emit()


func change_rotate_speed(value: float) -> void:
	Manager.options["rotate_speed"] = value
	Manager.options_updated.emit()


func change_camera_speed(value: float) -> void:
	Manager.options["camera_speed"] = value
	Manager.options_updated.emit()


func toggle_enable_damping(toggled_on: bool) -> void:
	Manager.options["enable_damping"] = toggled_on
	Manager.options_updated.emit()


# Video
func change_resolution(value: float) -> void:
	Manager.options["resolution"] = value
	Manager.options_updated.emit()


func toggle_power_saving(toggled_on: bool) -> void:
	Manager.options["power_saving"] = toggled_on
	Manager.options_updated.emit()


func toggle_fullscreen(toggled_on: bool) -> void:
	Manager.options["fullscreen"] = toggled_on
	Manager.options_updated.emit()
