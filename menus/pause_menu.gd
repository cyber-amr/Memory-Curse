extends Node


var options_menu : PackedScene = load("res://menus/options_menu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		on_continue()


func _ready() -> void:
	Engine.time_scale = 0


func on_continue() -> void:
	Engine.time_scale = 1
	queue_free()


func on_options() -> void:
	if !has_node("OptionsMenu"):
		add_child(options_menu.instantiate())


func on_exit() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
