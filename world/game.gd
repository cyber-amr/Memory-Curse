extends Node3D


@onready var render_viewport := $SubViewportContainer


func _ready() -> void:
	Manager.options_updated.connect(update_resolution)


func update_resolution() -> void:
	render_viewport.stretch_shrink = Manager.options["resolution"]
