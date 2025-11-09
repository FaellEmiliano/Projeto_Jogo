extends Label

var vida_atual :int
var texto
@onready var esqueleto_boss_2: CharacterBody2D = $"../../.."

func _physics_process(_delta: float) -> void:
	vida_atual = esqueleto_boss_2.vida
	texto = 'Zumbi' + str(vida_atual) + '/' + '25000'
	text = texto
	if vida_atual <= 0:
		queue_free()
