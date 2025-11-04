extends Node2D
var inimigos := [0,0,0,0]
@onready var inimigo1 = load("res://cenas/zumbi.tscn")
@onready var inimigo2 = load("res://cenas/esqueleto.tscn")
@onready var sala = $".."
@onready var mundo = $"../../.."


func _on_area_sala_body_entered(body: Node2D) -> void:
	await get_tree().process_frame  # Espera um frame para garantir que tudo carregou
	print(inimigos)
	if body.is_in_group("character") and not sala.player_entrou:
		print(inimigos)
		for c in range(get_child_count()):
			if inimigos[c] == 1:
				sala.inimigos += 1
				var inimigo_inst = inimigo1.instantiate()
			if inimigos[c] != 0:
				sala.inimigos +=1
				var inimigo_inst 
				if inimigos[c] == 1:
					inimigo_inst = inimigo1.instantiate()
				if inimigos[c] == 2:
					inimigo_inst = inimigo2.instantiate()
				var marcador = get_child(c)
				inimigo_inst.position = marcador.position
				normalizar_dificuldade(inimigo_inst)
				add_child(inimigo_inst)

func aleatorizar():
	var valores = [0, 1, 2]
	var pesos = sala.pesos_inimigos  
	var soma_total = 0
	for p in pesos:
		soma_total += p
	var r = randf() * soma_total  
	var acumulado = 0
	for i in range(valores.size()):
		acumulado += pesos[i]
		if r <= acumulado:
			return valores[i]

func normalizar_dificuldade(inimigo):
	inimigo.atualizar(mundo.multiplicador)
	

func _ready() -> void:
	print(mundo.name)
	for c in range(inimigos.size()):
		inimigos[c] = aleatorizar()
