extends Node3D


var pause_menu : PackedScene = load("res://menus/pause_menu.tscn")
@onready var render_viewport := $SubViewportContainer
@onready var camera := $"%OrbitCamera"

var selected_unit : Unit


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		pause()


func _ready() -> void:
	Engine.time_scale = 1
	update_resolution()
	Manager.options_updated.connect(update_resolution)


func _process(delta: float) -> void:
	var move_x = Input.get_axis("move_left", "move_right")
	var move_z = Input.get_axis("move_forward", "move_backward")

	if selected_unit:
		var speed : float = selected_unit.speed if selected_unit.speed else 0
		selected_unit.velocity = speed * Vector3(move_x, 0, move_z)
	else:
		camera.origin += delta * 5 * Manager.options["camera_speed"] * Vector3(move_x, 0, move_z)


func update_resolution() -> void:
	render_viewport.stretch_shrink = -Manager.options["resolution"]


func pause() -> void:
	if !has_node("UI/PauseMenu"):
		$UI.add_child(pause_menu.instantiate())
