# Código temporário
#Desenha o mapa usando tilemaps, só para teste
#quando implementar a criação de mapa é melhor instancia um nó de sala ja co;letao e calcula a posicao dele

extends TileMapLayer

@export var gerador_nó :NodePath

func _ready() -> void:
	var gerador = get_node(gerador_nó)
	var mapa = gerador.gerar()
	
	#desenha o mapa
	for x in mapa.size():
		for y in mapa[x].size():
			if str(mapa[x][y]) == "0":
				continue
			elif str(mapa[x][y]) == "I":
				set_cell(Vector2i(x,y), 1,Vector2i(0,0),0)
			else:
				set_cell(Vector2i(x,y), 1,Vector2i(0,0),0)
				
