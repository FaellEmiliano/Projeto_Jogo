extends Node2D

@onready var area_2d: Area2D = $Area2D

const lines :Array[String] = ["Eu preciso ir até o fim da masmorra !"]

func _unhandled_input(_event: InputEvent) -> void:
	if area_2d.get_overlapping_bodies().size() > 0:
		if !GerenciadorDialogo.is_message_active:
			await get_tree().create_timer(1.0).timeout
			GerenciadorDialogo.start_message(global_position,lines)
