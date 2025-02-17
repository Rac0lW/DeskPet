extends Resource
class_name SaveGame

#const SAVE_PATH:String = "res://save_files.tres"
static var DOWNLOAD_PATH:String = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/save_files.tres"

@export var text_save:String = ""

func save_game() -> void:
	ResourceSaver.save(self, DOWNLOAD_PATH)
	
static func load_game() -> Resource:
	#print(DOWNLOAD_PATH)
	if ResourceLoader.exists(DOWNLOAD_PATH):
		return load(DOWNLOAD_PATH)
	return null
