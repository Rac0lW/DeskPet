extends Label

var is_entering:bool = false
var is_draging:bool = false

var diff:Vector2i

func _input(event: InputEvent) -> void:
	if is_entering == false:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_draging = true
				diff = DisplayServer.mouse_get_position() - DisplayServer.window_get_position()
			else:
				is_draging = false
		

func _process(delta: float) -> void:
	if is_draging == false:
		return
	
	DisplayServer.window_set_position(DisplayServer.mouse_get_position() - diff)


func _on_mouse_entered() -> void:
	is_entering = true


func _on_mouse_exited() -> void:
	is_entering = false
