extends Node


var game_scene := load("res://world/game.tscn")
var options_menu : PackedScene = load("res://menus/options_menu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_on_quit()


func _on_start() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_options() -> void:
	if !has_node("OptionsMenu"):
		add_child(options_menu.instantiate())


func _on_quit() -> void:
	get_tree().quit()
