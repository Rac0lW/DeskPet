extends Node

var is_hiding: bool = false
var is_running_hiding_animation: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		get_tree().quit()

	
