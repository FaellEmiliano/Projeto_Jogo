extends Label
var vida_max :int
var vida_atual :int
var texto
@onready var zumbi_boss = $"../../.."

func _physics_process(_delta: float) -> void:
	vida_atual = zumbi_boss.vida
	texto = str(vida_atual) + '/' + str(vida_max)
	text = texto
