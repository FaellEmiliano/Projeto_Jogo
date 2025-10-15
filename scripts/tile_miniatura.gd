extends TileMapLayer

@export var gerador_nó :NodePath
@onready var gerador = get_node(gerador_nó)
@onready var gerenciador = $"../../../../Gerenciador_mapa"
@onready var mapa = gerador.Mapa
@onready var tilemap = $"."
var posicao : Vector2i

func pegar_pos(global_pos: Vector2i) -> Vector2i:

	# evitar divisões por zero
	var divisor = gerenciador.sala_const.get_node("TileMapLayer").tile_set.tile_size * gerenciador.pegar_tamanho()
	if divisor.x == 0 or divisor.y == 0:
		push_warning("tile_size ou offset tem valor zero!")
		return Vector2i.ZERO

	# calcula e arredonda
	var pos_matriz = global_pos / divisor
	return Vector2i(round(pos_matriz.x), round(pos_matriz.y))


func _ready() -> void:
	eventos.desenhar_mapa.connect(func(sala):
		posicao = pegar_pos(sala.global_position)
		tilemap.set_cell(posicao,2,Vector2i(0,0),0)
	)
	
	for x in mapa.size():
		for y in mapa[x].size():
			if mapa[x][y] == 0:
				continue
			elif mapa[x][y] == -1:
				tilemap.set_cell(Vector2i(x,y),1,Vector2i(0,0),0)
			else:
				tilemap.set_cell(Vector2i(x,y),1,Vector2i(0,0),0)
