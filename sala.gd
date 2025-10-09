extends Node2D
var player_entrou :bool = false
@onready var tilemap = $TileMapLayer
var vizinhos_instanciados :Array


func _on_area_sala_body_exited(body: Node2D) -> void:
	if body.is_in_group("enimy"):
		abrir_portas(vizinhos_instanciados)

func fechar_portas(vizinhos:Array):
	for c in vizinhos:
		if c == "N":
			tilemap.set_cell(Vector2i(0,-3),0,Vector2i(0,0),0)
		if c == "S":
			tilemap.set_cell(Vector2i(0,3),0,Vector2i(0,0),0)
		if c == "L":
			tilemap.set_cell(Vector2i(3,0),0,Vector2i(0,0),0)
		if c == "O":
			tilemap.set_cell(Vector2i(-3,0),0,Vector2i(0,0),0)

func abrir_portas(vizinhos:Array):
	vizinhos_instanciados = vizinhos
	for c in vizinhos:
		if c == "N":
			tilemap.set_cell(Vector2i(0,-3),1,Vector2i(0,0),0)
		if c == "S":
			tilemap.set_cell(Vector2i(0,3),1,Vector2i(0,0),0)
		if c == "L":
			tilemap.set_cell(Vector2i(3,0),1,Vector2i(0,0),0)
		if c == "O":
			tilemap.set_cell(Vector2i(-3,0),1,Vector2i(0,0),0)

func _on_area_sala_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		fechar_portas(vizinhos_instanciados)
	
