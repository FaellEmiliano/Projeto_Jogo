extends TextureProgressBar

@onready var jogador =  $"../../.."

func _physics_process(_delta: float) -> void:
	value = jogador.vida
