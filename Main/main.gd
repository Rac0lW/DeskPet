extends Control

@export var offset:int = 40
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var text_edit: TextEdit
@export var hide_start_windows_pos:Vector2i
@export var hide_end_windows_pos:Vector2i

var save_manager:SaveGame = SaveGame.new()
var is_hiding:bool = false
#-------------------------------------------------------------------------------


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Save"):
		_save_game()
	
	if event.is_action_pressed("Hide"):
			#animation_player.play("Hide")
			pass

func _ready() -> void:
	boot()
	
	_load_game()
	

func boot():
	#var win_pos = DisplayServer.window_get_position()
	var screen_size = DisplayServer.screen_get_size()
	
	var right_pos_x = screen_size.x - offset - size.x
	var right_pos_y = screen_size.y - offset - size.y - 48
	
	var right_pos:Vector2i = Vector2i(right_pos_x, right_pos_y)
	#print(right_pos)
	DisplayServer.window_set_position(right_pos)
	
	animation_player.play("Init")

func _load_game() -> void:
	text_edit.text = SaveGame.load_game().text_save
	
func _save_game() -> void:
	save_manager.text_save = text_edit.text
	save_manager.save_game()

func _set_window_pos(pos: Vector2i):
	DisplayServer.window_set_position(pos)

#-------------------------------------------------------------------------------

func _on_text_edit_text_changed() -> void:
	_save_game()


func _on_save_button_pressed() -> void:
	_save_game()


func _on_load_button_pressed() -> void:
	_load_game()
