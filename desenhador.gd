extends Node2D

#globais
@export var gerador_nó :NodePath
@export var camera_node : NodePath
var sala = load("res://sala.tscn")
var sala_const = sala.instantiate()
var pos_anterior := Vector2i(0,0)
var offset = pegar_tamanho()
@onready var gerador = get_node(gerador_nó)
@onready var mapa = gerador.gerar()

func pegar_vizinhos(pos :Vector2i) -> Array:
	var vizinhos = []
	var atual = mapa[pos.x][pos.y]
	if(pos.x + Vector2i.UP.x < gerador.Dimensoes.x and pos.y + Vector2i.UP.y < gerador.Dimensoes.y):
		if(mapa[pos.x + Vector2i.UP.x][pos.y + Vector2i.UP.y] != 0 and (mapa[pos.x + Vector2i.UP.x][pos.y + Vector2i.UP.y] -1 == atual or mapa[pos.x + Vector2i.UP.x][pos.y + Vector2i.UP.y] +1 == atual or (mapa[pos.x + Vector2i.UP.x][pos.y + Vector2i.UP.y] == -1 and atual == gerador.Tamanho_Mínimo)) or (atual == -1 and mapa[pos.x + Vector2i.UP.x][pos.y + Vector2i.UP.y] == gerador.Tamanho_Mínimo)):
			vizinhos.append("N")
	if(pos.x + Vector2i.DOWN.x < gerador.Dimensoes.x and pos.y + Vector2i.DOWN.y < gerador.Dimensoes.y):
		if(mapa[pos.x + Vector2i.DOWN.x][pos.y + Vector2i.DOWN.y] != 0 and (mapa[pos.x + Vector2i.DOWN.x][pos.y + Vector2i.DOWN.y] -1 == atual or mapa[pos.x + Vector2i.DOWN.x][pos.y + Vector2i.DOWN.y] +1 == atual or (mapa[pos.x + Vector2i.DOWN.x][pos.y + Vector2i.DOWN.y] == -1 and atual == gerador.Tamanho_Mínimo)) or (atual == -1 and mapa[pos.x + Vector2i.DOWN.x][pos.y + Vector2i.DOWN.y] == gerador.Tamanho_Mínimo)):
			vizinhos.append("S")
	if(pos.x + Vector2i.LEFT.x < gerador.Dimensoes.x and pos.y + Vector2i.LEFT.y < gerador.Dimensoes.y):
		if(mapa[pos.x + Vector2i.LEFT.x][pos.y + Vector2i.LEFT.y] != 0 and (mapa[pos.x + Vector2i.LEFT.x][pos.y + Vector2i.LEFT.y] -1 == atual or mapa[pos.x + Vector2i.LEFT.x][pos.y + Vector2i.LEFT.y] +1 == atual or (mapa[pos.x + Vector2i.LEFT.x][pos.y + Vector2i.LEFT.y] == -1 and atual == gerador.Tamanho_Mínimo)) or (atual == -1 and mapa[pos.x + Vector2i.LEFT.x][pos.y + Vector2i.LEFT.y] == gerador.Tamanho_Mínimo)):
			vizinhos.append("O")
	if(pos.x + Vector2i.RIGHT.x < gerador.Dimensoes.x and pos.y + Vector2i.RIGHT.y < gerador.Dimensoes.y):
		if(mapa[pos.x + Vector2i.RIGHT.x][pos.y + Vector2i.RIGHT.y] != 0 and (mapa[pos.x + Vector2i.RIGHT.x][pos.y + Vector2i.RIGHT.y] -1 == atual or mapa[pos.x + Vector2i.RIGHT.x][pos.y + Vector2i.RIGHT.y] +1 == atual or (mapa[pos.x + Vector2i.RIGHT.x][pos.y + Vector2i.RIGHT.y] == -1 and atual == gerador.Tamanho_Mínimo)) or (atual == -1 and mapa[pos.x + Vector2i.RIGHT.x][pos.y + Vector2i.RIGHT.y] == gerador.Tamanho_Mínimo)):
			vizinhos.append("L")
	return(vizinhos)
	

func pegar_tamanho() -> Vector2i:
	#pega constantes da sala
	var celulas_sala = sala_const.get_node("TileMapLayer").get_used_cells() #array de Vector2i
	var valores_x = []
	var valores_y = []
	for c in celulas_sala:
		valores_x.append(c.x)
		valores_y.append(c.y)
	var delta_sala = celulas_sala.max() - celulas_sala.min()
	var tamanho_sala = Vector2i(1,1) + delta_sala
	return(tamanho_sala)
	

func posicionar_sala(pos :Vector2i, flag :bool) -> void:
	var sala_inst = sala.instantiate()
	sala_inst.position = pos * sala_const.get_node("TileMapLayer").tile_set.tile_size * offset
	sala_inst.position = pos * sala_const.get_node("TileMapLayer").tile_set.tile_size * offset
	add_child(sala_inst)
	if flag:
		get_parent().get_node("jogador").position = sala_inst.position
	#Fecha portas
	var vizinhos = pegar_vizinhos(pos)
	for c in vizinhos:
		if c == "N":
			sala_inst.remove_child(sala_inst.get_node("conexao_norte"))
		if c == "S":
			sala_inst.remove_child(sala_inst.get_node("conexao_sul"))
		if c == "L":
			sala_inst.remove_child(sala_inst.get_node("conexao_leste"))
		if c == "O":
			sala_inst.remove_child(sala_inst.get_node("conexao_oeste"))

func _ready() -> void:
	for x in mapa.size():
		for y in mapa[x].size():
			if mapa[x][y] == 0:
				continue
			elif mapa[x][y] == -1:
				pos_anterior = Vector2(x,y)
				posicionar_sala(pos_anterior, 1)
			else:
				posicionar_sala(Vector2i(x,y), 0)
				pos_anterior = Vector2i(x,y)
