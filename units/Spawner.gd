class_name Spawner
extends Structure


@export var unit : String
@export var spawn_point := Vector3.ZERO
@export var rate : int = 5 # seconds

var timer := Timer.new()


func _ready() -> void:
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.wait_time = rate
	timer.autostart = true
	timer.timeout.connect(spawn)
	add_child(timer)


func spawn() -> void:
	var u := Manager.new_unit(unit)
	u.is_enemy = is_enemy
	get_parent().add_child(u)
	u.global_position = global_position + spawn_point
