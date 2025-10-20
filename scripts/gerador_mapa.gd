extends Node2D

#globais
@export var Dimensoes :Vector2i = Vector2i(5,5)
@export var Tamanho_Mínimo :int = 15
@export var galhos :int = 3
@export var tamanho_galhos :Vector2i = Vector2i(1,4)
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
func g_inicio() -> Vector2i:
	var inicio :Vector2i
	inicio.x = randi_range(0,Dimensoes.x - 1)
	inicio.y = randi_range(0,Dimensoes.y - 1)
	Mapa[inicio.x][inicio.y] = -1
	return inicio

#cria o caminho "principal"
func g_caminho(anterior :Vector2i, nivel :int):
	if (nivel == 0):
		return 1
	var atual :Vector2i = anterior
	var direcao :Vector2i
	match randi() % 4:
		0:
			direcao = Vector2i.UP
		1:
			direcao = Vector2i.DOWN
		2:
			direcao = Vector2i.LEFT
		3:
			direcao = Vector2i.RIGHT
	for i in 4:
		var proximo = atual + direcao
		if(Dimensoes.x > proximo.x and proximo.x >= 0 and Dimensoes.y > proximo.y and proximo.y>= 0 and not Mapa[proximo.x][proximo.y]):
			atual += direcao
			Mapa[atual.x][atual.y] = nivel
			if g_caminho(atual,nivel-1): 
				return true
			else:
				Mapa[atual.x][atual.y] = 0
				atual -= direcao
		direcao = Vector2i(direcao.y, -direcao.x)
	return false
	


func gerar():
	var sucesso = false
	while not sucesso:
		Mapa.clear()
		inicializar_mapa()
		sucesso = g_caminho(g_inicio(), Tamanho_Mínimo)
	imprimir_mapa()
	return Mapa


func _ready() -> void:
	Mapa = gerar()
