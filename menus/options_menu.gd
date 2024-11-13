extends Node


func _ready() -> void:
	update()
	Manager.options_updated.connect(update)


func back():
	Manager.save_options()
	queue_free()


func update():
	# Video
	$"%ResolutionSlider".value = Manager.options["resolution"]


func change_resolution(value: float) -> void:
	Manager.options["resolution"] = value
	Manager.options_updated.emit()
