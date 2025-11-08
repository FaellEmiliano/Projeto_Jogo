extends TextureProgressBar

@onready var boss =  $"../.."

func _physics_process(_delta: float) -> void:
	value = boss.vida
	max_value = upgrade.vida_max
