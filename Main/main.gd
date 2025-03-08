extends Control
@export var offset:int = 40
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var text_edit: TextEdit

@export var current_window_pos:Vector2i
@export var start_window_pos:Vector2i
@export var hiding_window_pos:Vector2i
@export var peak_window_pos:Vector2i

@export var animation_speed:float

@onready var timer: Timer = $Timer
#@onready var panel: Panel = $Panel
@onready var peak_panel: PeakPanel = $PeakPanel
@onready var big_timer: Timer = $BigTimer

var save_manager:SaveGame = SaveGame.new()

#-------------------------------------------------------------------------------


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		big_timer.stop()

func _ready() -> void:
	boot()
	
	_load_game()
	
	peak_panel.peak_panel_sig.connect(_cancel)

func boot():
	#var win_pos = DisplayServer.window_get_position()
	var screen_size = DisplayServer.screen_get_size()
	
	var right_pos_x = screen_size.x - offset - size.x
	var right_pos_y = screen_size.y - offset - size.y - 48
	
	var right_pos:Vector2i = Vector2i(right_pos_x, right_pos_y)
	#print(right_pos)
	DisplayServer.window_set_position(right_pos)
	
	animation_player.play("Init")
	
	big_timer.start()
	
	first_boot_for_window_pos_set()
#-------------------------------------------------------------------------------
#Saving and Loading
func _load_game() -> void:
	if SaveGame.load_game():
		text_edit.text = SaveGame.load_game().text_save
	
func _save_game() -> void:
	save_manager.text_save = text_edit.text
	save_manager.save_game()
#-------------------------------------------------------------------------------

func _set_window_pos(pos: Vector2i):
	DisplayServer.window_set_position(pos)
#-------------------------------------------------------------------------------
func _process(delta: float) -> void:
	if Setting.is_running_hiding_animation:
		DisplayServer.window_set_position(current_window_pos)
		
	if !DisplayServer.window_is_focused():
		if Setting.isLocking:
			return
		
		if big_timer.is_stopped():
			big_timer.start()
#-------------------------------------------------------------------------------

func first_boot_for_window_pos_set():
	current_window_pos = DisplayServer.window_get_position()
	start_window_pos = DisplayServer.window_get_position()
	hiding_window_pos = DisplayServer.screen_get_size() - Vector2i(8, 8)
	peak_window_pos = DisplayServer.screen_get_size() - Vector2i(128, 128)
	



#-------------------------------------------------------------------------------
#Animation
func _start_hiding():
	var tween = create_tween()
	Setting.is_running_hiding_animation = true
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "current_window_pos", hiding_window_pos, animation_speed)
	#print(Setting.is_running_hiding_animation)
	tween.chain().tween_callback(_stop_animation)
	peak_panel.visible = true

func _cancel():
	Setting.current_window_state = Setting.WindowStates.Normal
	var tween = create_tween()
	Setting.is_running_hiding_animation = true
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "current_window_pos", start_window_pos, animation_speed)
	#print(Setting.is_running_hiding_animation)
	tween.chain().tween_callback(_stop_animation)
	peak_panel.visible = false

func _peaking():
	var tween = create_tween()
	Setting.is_running_hiding_animation = true
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "current_window_pos", peak_window_pos, animation_speed)
	#print(Setting.is_running_hiding_animation)
	tween.chain().tween_callback(_stop_animation)
	peak_panel.visible = true
	

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

func _stop_animation():
	Setting.is_running_hiding_animation = false
	#print(Setting.is_running_hiding_animation)

func _on_text_edit_text_changed() -> void:
	_save_game()
#-------------------------------------------------------------------------------


func _on_panel_mouse_entered() -> void:
	if Setting.current_window_state == Setting.WindowStates.Hiding:
		Setting.current_window_state = Setting.WindowStates.Peaking
		_peaking()


func _on_panel_mouse_exited() -> void:
	timer.start()
#-------------------------------------------------------------------------------
#timer behaviors

func _on_timer_timeout() -> void:
	if Setting.current_window_state == Setting.WindowStates.Peaking:
		Setting.current_window_state = Setting.WindowStates.Hiding
		_start_hiding()
		


func _on_big_timer_timeout() -> void:
	if Setting.current_window_state == Setting.WindowStates.Normal:
		Setting.current_window_state = Setting.WindowStates.Hiding
		_start_hiding()
#-------------------------------------------------------------------------------
