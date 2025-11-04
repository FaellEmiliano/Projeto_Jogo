extends Camera2D

func _ready() -> void:
	eventos.player_entrou.connect(func(sala):
		global_position = sala.global_position
	)
