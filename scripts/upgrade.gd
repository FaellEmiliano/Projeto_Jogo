extends Node
@export var regen = 1
@export var dano = 500
@export var speed :float = 300
@export var veloc_tiro:float = 300
@export var fire_rate :float = 0.5
var upgrades :Array = [0,0,0] #Vida,Dano,Velocd
var vida_max: float = 100

func atualizar(flag :int):
	if flag == 1:
		vida_max += vida_max/10 * upgrades[0]
		regen += upgrades[0] * 1.5
	elif flag == 2:
		dano += 250
	elif flag == 3:
		speed += speed/10 * upgrades[2]
		fire_rate -= fire_rate/10 * upgrades[2]

func reset():
	regen = 1
	dano = 500
	speed = 300
	veloc_tiro = 300
	fire_rate = 0.5
	upgrades = [0,0,0] #Vida,Dano,Velocd
	vida_max = 100
