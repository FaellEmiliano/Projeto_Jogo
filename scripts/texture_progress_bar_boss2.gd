extends TextureProgressBar

@onready var esqueleto_boss =  $"../.."

func _physics_process(_delta: float) -> void:
	value = esqueleto_boss.vida
