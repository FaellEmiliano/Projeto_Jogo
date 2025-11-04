extends Control

@onready var zumbi = $AnimatedSprite2D
@onready var personagem = $AnimatedSprite2D2

func _ready() -> void:
	zumbi.play("nrml")
	personagem.play("nrml")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/interface_sec.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
