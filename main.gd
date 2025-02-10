extends Control

@export var offset:int = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boot()


func boot():
	var win_pos = DisplayServer.window_get_position()
	var screen_size = DisplayServer.screen_get_size()
	
	var right_pos_x = screen_size.x - offset - size.x
	var right_pos_y = screen_size.y - offset - size.y - 48
	
	var right_pos:Vector2i = Vector2i(right_pos_x, right_pos_y)
	
	DisplayServer.window_set_position(right_pos)
