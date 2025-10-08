extends Node2D
var player_entrou :bool = false


func _on_area_sala_body_exited(body: Node2D) -> void:
	if body.is_in_group("enimy"):
		abrir_portas()

func fechar_portas():
	add_child(get_node("portas"))

func abrir_portas():
	remove_child(get_node("portas"))



func _ready() -> void:
	abrir_portas()


func _on_area_sala_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		fechar_portas()
		
	
