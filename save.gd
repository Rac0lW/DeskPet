extends Resource
class_name SaveGame

const SAVE_PATH:String = "res://save_files.tres"

@export var text_save:String = ""

func save_game() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_game() -> Resource:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	return null
