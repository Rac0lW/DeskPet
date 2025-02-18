extends Panel
class_name PeakPanel
signal peak_panel_sig
@onready var timer: Timer = $"../Timer"

func _gui_input(event: InputEvent) -> void:
	timer.stop()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			peak_panel_sig.emit()
