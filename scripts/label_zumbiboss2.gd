extends Label

var vida_atual :int
var texto
@onready var zumbi_boss2 = $"../../.."

func _physics_process(_delta: float) -> void:
	vida_atual = zumbi_boss2.vida
	texto = 'Zumbi' + str(vida_atual) + '/' + '10000'
	text = texto
	if vida_atual <= 0:
		queue_free()
