extends Node2D

#globais
@export var gerador_nó :NodePath
@export var camera_node : NodePath
@onready var mundo: Node2D = $".."
@onready var nivel = mundo.nivel
var jogador = load("res://cenas/Personagem.tscn")
var sala_const = load("res://cenas/sala.tscn").instantiate()
var pos_anterior := Vector2i(0,0)
var offset = pegar_tamanho()
@onready var gerador = get_node(gerador_nó)
@onready var mapa = gerador.Mapa
@onready var jogador_inst = jogador.instantiate()

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
	var celulas_sala = sala_const.get_node("TSala").get_used_cells() #array de Vector2i
	var valores_x = []
	var valores_y = []
	for c in celulas_sala:
		valores_x.append(c.x)
		valores_y.append(c.y)
	var delta_sala = celulas_sala.max() - celulas_sala.min()
	var tamanho_sala = Vector2i(1,1) + delta_sala
	return(tamanho_sala)
	

func posicionar_sala(pos :Vector2i, flag :int) -> void:
	var sala_inst
	var sala_segura
	var sala_inicial
	if flag == 2:
		if nivel == 1:
			sala_segura = load("res://cenas/sala_segura.tscn")
		if nivel == 2:
			sala_segura = load("res://cenas/sala_segura.tscn")
		sala_inst = sala_segura.instantiate()
	elif flag == 1:
		if nivel == 1:
			sala_inicial = load("res://cenas/sala_inicial.tscn")
		if nivel == 2:
			sala_inicial = load("res://cenas/sala_inicial.tscn")
		sala_inst = sala_inicial.instantiate()
	else:
		var sala
		if nivel == 1:
			sala = load("res://cenas/sala.tscn")
		if nivel == 2:
			sala = load("res://cenas/sala2.tscn")
		sala_inst = sala.instantiate()
	sala_inst.position = pos * sala_const.get_node("TSala").tile_set.tile_size * offset
	sala_inst.position = pos * sala_const.get_node("TSala").tile_set.tile_size * offset
	add_child(sala_inst)
	if flag == 1:
		jogador_inst.position = sala_inst.position + Vector2(486,292)
		
	#Fecha portas
	sala_inst.abrir_portas(pegar_vizinhos(pos))


func _ready() -> void:
	add_child(jogador_inst)
	for x in mapa.size():
		for y in mapa[x].size():
			if mapa[x][y] == 0:
				continue
			elif mapa[x][y] == -1:
				pos_anterior = Vector2(x,y)
				posicionar_sala(pos_anterior, 1)
			elif mapa[x][y] in [12,8,4]:
				pos_anterior = Vector2(x,y)
				posicionar_sala(pos_anterior, 2)
			else:
				posicionar_sala(Vector2i(x,y), 0)
				pos_anterior = Vector2i(x,y)
	
