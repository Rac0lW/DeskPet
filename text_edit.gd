extends TextEdit

var target_label:Label




func _on_text_changed() -> void:
	target_label = get_tree().get_nodes_in_group("Label").back()
	var lines = text.split("\n")
	if lines.size() > 0:
		target_label.text = lines[0]
	else:
		target_label.text = ""
