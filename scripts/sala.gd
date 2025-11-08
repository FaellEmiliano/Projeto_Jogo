extends Node2D
var player_entrou :bool = false
var inimigos :int = 1
@onready var tilemap = $TSala
var vizinhos_instanciados :Array
var pesos_inimigos = [1,4,5]
var boss = load("res://cenas/zumbi_boss.tscn")



func _on_area_sala_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		inimigos -= 1
		if inimigos <=0:
			abrir_portas(vizinhos_instanciados)
			player_entrou = 1

func fechar_portas(vizinhos:Array):
	for c in vizinhos:
		if c == "N":
			tilemap.set_cell(Vector2i(7,1),6,Vector2i(0,0),0)
		if c == "S":
			tilemap.set_cell(Vector2i(7,7),6,Vector2i(0,2),0)
		if c == "L":
			tilemap.set_cell(Vector2i(13,4),6,Vector2i(0,3),0)
		if c == "O":
			tilemap.set_cell(Vector2i(1,4),6,Vector2i(0,1),0)

func abrir_portas(vizinhos:Array):
	vizinhos_instanciados = vizinhos
	for c in vizinhos:
		if c == "N":
			tilemap.set_cell(Vector2i(7,1),5,Vector2i(0,0),0)
		if c == "S":
			tilemap.set_cell(Vector2i(7,7),5,Vector2i(0,2),0)
		if c == "L":
			tilemap.set_cell(Vector2i(13,4),5,Vector2i(0,3),0)
		if c == "O":
			tilemap.set_cell(Vector2i(1,4),5,Vector2i(0,1),0)

func _on_area_sala_body_entered(body: Node2D) -> void:
	eventos.player_entrou.emit(self)
	if body.is_in_group("character") and not player_entrou:
		if self.name == "Sala_final":
			var zumbi = boss.instantiate()
			zumbi.position = Vector2(480,286)
			add_child(zumbi)
		
		eventos.desenhar_mapa.emit(self)
		fechar_portas(vizinhos_instanciados)
		
	
func _process(_delta: float) -> void:
	if player_entrou:
		abrir_portas(vizinhos_instanciados)
	

func _on_saida_body_entered(_body: Node2D) -> void:
	if inimigos <= 0:
		get_tree().change_scene_to_file("res://cenas/Mundo2.tscn")
