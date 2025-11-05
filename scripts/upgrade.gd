extends Node
@export var regen = 1
@export var dano = 500
var upgrades :Array = [0,0,0] #Vida,Dano,Velocd
var vida_max: float = 100

func atualizar(flag :int):
	if flag == 1:
		vida_max += vida_max/10 * upgrades[0]
		regen += upgrades[0] * 2
	elif flag == 2:
		dano += 250
		
func reset():
	regen = 1
	dano = 500
	upgrades = [0,0,0] #Vida,Dano,Velocd
	vida_max = 100
