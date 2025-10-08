extends Area2D

var veloc = 0
var direcao: Vector2 = Vector2.ZERO
@export var Dano :int = 500

func _ready() -> void:
	z_index = -1
func _physics_process(delta: float) -> void:
	position += veloc * direcao * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body) -> void:
	if body.has_method("dano"):
		body.dano(Dano)
	queue_free()
