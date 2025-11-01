extends Button

@onready var menu = $menu
@onready var resume_button = $menu/VBoxContainer/resume


func _on_pressed() -> void:
	menu.visible = true
	get_tree().paused = true
	resume_button.grab_focus()
