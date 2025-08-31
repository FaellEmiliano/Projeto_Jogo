extends Area2D

@export var velocidade: float = 500.0
var direcao = Vector2.ZERO

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	position += direcao*velocidade*delta


func _on_body_entered(body: Node2D) -> void:
	if body.name != "jogador":
		queue_free()
