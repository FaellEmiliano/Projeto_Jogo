extends Node

@onready var caixa_dialogo_cena = preload("res://cenas/caixa_dialogo.tscn")
var message_lines : Array[String] = []
var current_line = 0

var dialog_box
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false

func start_message(position: Vector2, lines: Array[String]):
	if is_message_active:
		return
		
	message_lines = lines
	dialog_box_position = position
	show_text()
	is_message_active = true
	
func show_text():
	dialog_box = caixa_dialogo_cena.instantiate()
	dialog_box.texto_finalizado.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false
	
func _on_all_text_displayed():
	can_advance_message = true
