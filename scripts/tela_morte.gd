extends CanvasLayer


func _on_reiniciar_nível_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/Mundo.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/interface_sec.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
