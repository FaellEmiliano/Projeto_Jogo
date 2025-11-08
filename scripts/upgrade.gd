extends Node
@export var regen = 1
@export var dano = 500
var upgrades :Array = [0,0,0] #Vida,Dano,Velocd
var vida_max: float = 100

func atualizar(flag :int):
	if flag == 1:
		vida_max += vida_max/10 * upgrades[0]
		regen += upgrades[0] * 1.5
	elif flag == 2:
		dano += 250
