extends Node3D


var pause_menu : PackedScene = load("res://menus/pause_menu.tscn")
@onready var render_viewport := $SubViewportContainer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		pause()


func _ready() -> void:
	Engine.time_scale = 1
	Manager.options_updated.connect(update_resolution)


func update_resolution() -> void:
	render_viewport.stretch_shrink = Manager.options["resolution"]


func pause() -> void:
	if !has_node("UI/PauseMenu"):
		$UI.add_child(pause_menu.instantiate())
