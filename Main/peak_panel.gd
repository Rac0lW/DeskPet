extends Panel
class_name PeakPanel
signal peak_panel_sig

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			peak_panel_sig.emit()
