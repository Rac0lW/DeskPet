extends Control

@export var offset:int = 40
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var text_edit: TextEdit = $MarginContainer/PanelContainer/VBoxContainer/TextEdit



@export var hide_start_windows_pos:Vector2i
@export var hide_end_windows_pos:Vector2i

#var is_hiding:bool = false
#var tween:Tween
var save_manager:SaveGame = SaveGame.new()
#@export var window_pos:Vector2i
#-------------------------------------------------------------------------------


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Save"):
		_save_game()
		
	#if event.is_action_pressed("Hide"):
		#if is_hiding:
			#is_hiding = false
			#_cancel_hiding()
		#else:
			#is_hiding = true
			#_start_hiding()

func _ready() -> void:
	boot()
	
	_load_game()
	
	#tween = create_tween()
	#window_pos = DisplayServer.window_get_position()
	#hide_start_windows_pos = DisplayServer.window_get_position()
	#hide_end_windows_pos = hide_start_windows_pos + DisplayServer.window_get_size() + Vector2i(46, 46)
	
func _process(delta: float) -> void:
	pass
	#if is_hiding:
		#DisplayServer.window_set_position(window_pos)
	
##-------------------------------------------------------------------------------
#func _start_hiding() -> void:
	#if is_hiding:
		#return
#
	#window_pos = DisplayServer.window_get_position()
	#tween.set_ease(Tween.EASE_OUT_IN)
	#tween.tween_property(self, "window_pos", hide_end_windows_pos, 0.5)
#
#func _cancel_hiding() -> void:
	#if !is_hiding:
		#return
		#
	#window_pos = DisplayServer.window_get_position()
	#tween.set_ease(Tween.EASE_OUT_IN)
	#tween.tween_property(self, "window_pos", hide_start_windows_pos, 0.5)

#-------------------------------------------------------------------------------

func boot():
	var win_pos = DisplayServer.window_get_position()
	var screen_size = DisplayServer.screen_get_size()
	
	var right_pos_x = screen_size.x - offset - size.x
	var right_pos_y = screen_size.y - offset - size.y - 48
	
	var right_pos:Vector2i = Vector2i(right_pos_x, right_pos_y)
	
	DisplayServer.window_set_position(right_pos)
	
	animation_player.play("Init")

func _load_game() -> void:
	var save = save_manager.load_game()
	text_edit.text = save.text_save
	
func _save_game() -> void:
	save_manager.text_save = text_edit.text
	save_manager.save_game()

#-------------------------------------------------------------------------------




#-------------------------------------------------------------------------------





#-------------------------------------------------------------------------------

func _on_text_edit_text_changed() -> void:
	_save_game()


func _on_save_button_pressed() -> void:
	_save_game()


func _on_load_button_pressed() -> void:
	_load_game()
