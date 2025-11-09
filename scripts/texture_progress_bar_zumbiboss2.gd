extends TextureProgressBar

@onready var zumbi_boss2 =  $"../.."

func _physics_process(_delta: float) -> void:
	value = zumbi_boss2.vida
