extends Label
var vida_max :int
var vida_atual :int
var texto
@onready var jogador = $"../../.."

func _physics_process(_delta: float) -> void:
	vida_atual = jogador.vida
	vida_max = upgrade.vida_max
	texto = str(vida_atual) + '/' + str(vida_max)
	text = texto
