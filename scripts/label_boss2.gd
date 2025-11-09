extends Label

var vida_atual :int
var texto
@onready var esqueleto_boss = $"../../.."

func _physics_process(_delta: float) -> void:
	vida_atual = esqueleto_boss.vida
	texto = str(vida_atual) + '/' + '15000'
	text = texto
	if vida_atual <= 0:
		queue_free()
