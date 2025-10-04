extends Node2D

#globais
@export var gerador_nó :NodePath
var sala = load("res://sala.tscn")
var sala_const = sala.instantiate()
var pos_anterior := Vector2i(0,0)
var offset = pegar_tamanho()


func pegar_tamanho() -> Vector2i:
	#pega contantes da sala
	var celulas_sala = sala_const.get_node("TileMapLayer").get_used_cells() #array de Vector2i
	var valores_x = []
	var valores_y = []
	for c in celulas_sala:
		valores_x.append(c.x)
		valores_y.append(c.y)
	var delta_sala = celulas_sala.max() - celulas_sala.min()
	print(delta_sala)
	var tamanho_sala = Vector2i(1,1) + delta_sala
	return(tamanho_sala)
	

func posicionar_sala(pos :Vector2i, flag :bool) -> void:
	var sala_inst = sala.instantiate()
	sala_inst.position = pos * sala_const.get_node("TileMapLayer").tile_set.tile_size * offset
	add_child(sala_inst)
	if flag:
		get_parent().get_node("jogador").position = sala_inst.position


func _ready() -> void:
	var gerador = get_node(gerador_nó)
	var mapa = gerador.gerar()
	for x in mapa.size():
		for y in mapa[x].size():
			if str(mapa[x][y]) == "0":
				continue
			elif str(mapa[x][y]) == "I":
				pos_anterior = Vector2(x,y)
				posicionar_sala(pos_anterior, 1)
			else:
				posicionar_sala(Vector2i(x,y), 0)
				pos_anterior = Vector2i(x,y)
