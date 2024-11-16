class_name OrbitCamera
extends Camera3D


@export var damping_factor: float =  0.1

@export var min_polar_angle: float = -1.5707 # deg2rad(-89.9945.0)
@export var max_polar_angle: float = 1.5707 # deg2rad( 89.9945.0)
@export var min_zoom_distance: float = 5.0
@export var max_zoom_distance: float = 50.0

@export var radius: float = 10.0
@export var polar_angle: float = 0.785398 # radians
@export var azimuth_angle: float = 0.785398 # radians

@export var target: Node3D
@export var origin: Vector3 = Vector3(0, 0, 0)

var dragging: bool = false
var _position: Vector3 = Vector3(0, 0, 0)

var zoom: float = 0
var azimuth_rotate: float = 0
var polar_rotate: float = 0


func _unhandled_input(event: InputEvent) -> void:
	zoom = 10 * Manager.options["zoom_speed"] * (event.get_action_strength("zoom_in") - event.get_action_strength("zoom_out"))

	if event.is_action("rotate_drag"):
		dragging = event.is_pressed()
	
	if event is InputEventMouseMotion && dragging:
		azimuth_rotate = 0.25 * Manager.options["sensitivity"] * -event.relative.x
		polar_rotate = 0.25 * Manager.options["sensitivity"] * event.relative.y
	else:
		azimuth_rotate = 3 * Manager.options["rotate_speed"] * (event.get_action_strength("rotate_right") - event.get_action_strength("rotate_left"))
		polar_rotate = 1.5 * Manager.options["rotate_speed"] * (event.get_action_strength("rotate_up") - event.get_action_strength("rotate_down"))


func _process(delta: float) -> void:
	radius = clamp(radius + (delta * zoom), min_zoom_distance, max_zoom_distance)

	azimuth_angle += delta * azimuth_rotate
	polar_angle = clamp(polar_angle + (delta * polar_rotate * 0.5), min_polar_angle, max_polar_angle)

	_position = Vector3(
		origin.x + radius * cos(polar_angle) * sin(azimuth_angle),
		origin.y + radius * sin(polar_angle),
		origin.z + radius * cos(polar_angle) * cos(azimuth_angle)
	)

	if Manager.options["enable_damping"]:
		global_transform.origin += (_position - global_transform.origin) * damping_factor
		if target:
			origin = lerp(origin, target.position, damping_factor)
	else:
		global_transform.origin = _position
		if target:
			origin = target.position

	if origin != global_transform.origin:
		look_at(origin)
