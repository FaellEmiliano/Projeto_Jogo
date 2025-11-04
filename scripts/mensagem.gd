extends Node2D

@onready var area_2d: Area2D = $Area2D

const lines :Array[String] = ["Tenho que chegar até o fim da masmorra!"]





func _on_area_2d_body_entered(body: Node2D) -> void:
	if !GerenciadorDialogo.is_message_active:
		await get_tree().create_timer(0.5).timeout
		GerenciadorDialogo.start_message(global_position,lines)
