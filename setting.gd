extends Node

enum WindowStates{
	Normal,
	Hiding,
	Peaking
}

var isLocking:bool = false

var is_running_hiding_animation: bool = false
var current_window_state = WindowStates.Normal

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		get_tree().quit()

	
