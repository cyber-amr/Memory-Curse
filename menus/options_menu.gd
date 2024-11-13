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


func change_resolution(value: float) -> void:
	Manager.options["resolution"] = value
	Manager.options_updated.emit()
