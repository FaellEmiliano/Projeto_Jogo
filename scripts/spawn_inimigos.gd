extends Node2D
var inimigos := [1,1,1,1]
@onready var inimigo1 = load("res://cenas/enimy.tscn")
@onready var sala = $".."

func _on_area_sala_body_entered(body: Node2D) -> void:
	if body.is_in_group("character") and not sala.player_entrou:
		for c in range(get_child_count()):
				sala.inimigos +=1
				var inimigo_inst = inimigo1.instantiate()
				var marcador = get_child(c)
				inimigo_inst.position = marcador.position
				add_child(inimigo_inst)
