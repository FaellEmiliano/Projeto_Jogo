extends TextureProgressBar

@onready var esqueleto_boss2 =  $"../.."

func _physics_process(_delta: float) -> void:
	value = esqueleto_boss2.vida
