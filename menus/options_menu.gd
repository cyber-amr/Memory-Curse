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


func update():
	# Video
	$"%ResolutionSlider".value = Manager.options["resolution"]
	$"%PowerSaving".button_pressed = Manager.options["power_saving"]
	$"%FullScreen".button_pressed = Manager.options["fullscreen"]


func change_resolution(value: float) -> void:
	Manager.options["resolution"] = value
	Manager.options_updated.emit()


func toggle_power_saving(toggled_on: bool) -> void:
	Manager.options["power_saving"] = toggled_on
	Manager.options_updated.emit()


func toggle_fullscreen(toggled_on: bool) -> void:
	Manager.options["fullscreen"] = toggled_on
	Manager.options_updated.emit()
