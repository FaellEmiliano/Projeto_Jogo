extends CanvasLayer

@onready var resume_button = $VBoxContainer/resume

func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true 
		resume_button.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false
