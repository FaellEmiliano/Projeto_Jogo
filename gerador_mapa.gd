extends Node2D

@export var Dimensoes :Vector2i = Vector2i(5,5)
@export var Tamanho_Mínimo :int = 5
var Mapa :Array

#setar o array em branco
func inicializar_mapa():
	for x in Dimensoes.x:
		Mapa.append([])
		for y in Dimensoes.y:
			Mapa[x].append(0)

#imprime o array no console
func imprimir_mapa():
	var mapa_escrito : String = ""
	for y in range(Dimensoes.y-1,-1,-1):
		for x in Dimensoes.x:
			if Mapa[x][y]:
				mapa_escrito += "[" + str(Mapa[x][y]) + "]"
			else:
				mapa_escrito += "[ ]"
		mapa_escrito += '\n'
	print(mapa_escrito)

#posiciona o inicio do mapa
func g_inicio():
	var inicio :Vector2i
	inicio.x = randi_range(0,Dimensoes.x - 1)
	inicio.y = randi_range(0,Dimensoes.y - 1)
	Mapa[inicio.x][inicio.y] = "I"

#cria o caminho "principal"
func g_caminho():
	pass
	


func _ready() -> void:
	inicializar_mapa()
	g_inicio()
	imprimir_mapa()
	
