extends TextEdit


@export var target_label:Label




func _on_text_changed() -> void:
	var lines = text.split("\n")
	if lines.size() > 0:
		target_label.text = lines[0]
	else:
		target_label.text = ""
