extends Area2D

var veloc = 0
var direcao: Vector2 = Vector2.ZERO

func _ready() -> void:
	z_index = -1
func _physics_process(delta: float) -> void:
	position += veloc * direcao * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
