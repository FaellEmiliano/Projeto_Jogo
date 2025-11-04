extends VBoxContainer



func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/tutorial.tscn")

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/Mundo.tscn")

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/interface_ini.tscn")
