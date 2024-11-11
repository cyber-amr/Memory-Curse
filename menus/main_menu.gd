extends Node


var game_scene := load("res://world/game.tscn")


func _on_start() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_options() -> void:
	pass # Replace with function body.


func _on_quit() -> void:
	get_tree().quit()
