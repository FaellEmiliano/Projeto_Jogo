extends TileMapLayer

@export var gerador_nó :NodePath
@onready var gerador = get_node(gerador_nó)
@onready var gerenciador = $"../../../../Gerenciador_mapa"
@onready var mapa = gerador.Mapa
@onready var tilemap = $"."
var posicao : Vector2i

func pegar_pos(global_pos: Vector2i) -> Vector2i:

	var divisor = gerenciador.sala_const.get_node("TSala").tile_set.tile_size * gerenciador.pegar_tamanho()
	if divisor.x == 0 or divisor.y == 0:
		push_warning("tile_size ou offset tem valor zero!")
		return Vector2i.ZERO

	var pos_matriz = global_pos / divisor
	return Vector2i(round(pos_matriz.x), round(pos_matriz.y))

func desenhar_tile(pos :Vector2i):
	tilemap.set_cell(pos,2,Vector2i(0,0),0)
	for c in gerenciador.pegar_vizinhos(pos):
		if c == "N" and tilemap.get_cell_source_id(pos + Vector2i.UP) != 2:
			tilemap.set_cell(pos + Vector2i.UP,1,Vector2i(0,0),0)
		if c == "S" and tilemap.get_cell_source_id(pos + Vector2i.DOWN) != 2:
			tilemap.set_cell(pos + Vector2i.DOWN,1,Vector2i(0,0),0)
		if c == "L" and tilemap.get_cell_source_id(pos + Vector2i.RIGHT) != 2:
			tilemap.set_cell(pos + Vector2i.RIGHT,1,Vector2i(0,0),0)
		if c == "O" and tilemap.get_cell_source_id(pos + Vector2i.LEFT) != 2:
			tilemap.set_cell(pos + Vector2i.LEFT,1,Vector2i(0,0),0)
	

func _ready() -> void:
	eventos.desenhar_mapa.connect(func(sala):
		posicao = pegar_pos(sala.global_position)
		desenhar_tile(posicao)
	)
	
	for x in mapa.size():
		for y in mapa[x].size():
			if mapa[x][y] == 0:
				continue
			elif mapa[x][y] == -1:
				tilemap.set_cell(Vector2i(x,y),1,Vector2i(0,0),0)
