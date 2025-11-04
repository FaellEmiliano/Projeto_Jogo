extends CharacterBody2D
class_name Enemy

var _player_ref = null

@export_category("object")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null

func _on_detectio_area_body_entered(_body) -> void:
	if is_in_group("character"):
		_player_ref = _body
		
		
func _on_detection_area_body_exited(_body) -> void:
	if is_in_group("character"):
		_player_ref = null
		
func _physics_process(delta: float) -> void:
	_animate()
	if _player_ref != null:
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		velocity = _direction * 100
		move_and_slide()
		
		
func _animate() -> void:
	if velocity.x > 0:
		_texture.flip_h = false
		
	if velocity.x < 0:
		_texture.flip_h = true

	if velocity != Vector2.ZERO:
		_animation.play("walk")
		return
		
	_animation.play("stand")
