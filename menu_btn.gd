extends Button

@onready var menu = $menu



func _on_pressed() -> void:
	menu.visible = true
	get_tree().paused = true
