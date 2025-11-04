extends Node2D
signal saiu()

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("character"):
		saiu.emit()
		queue_free()
