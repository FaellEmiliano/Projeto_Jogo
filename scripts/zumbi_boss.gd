extends CharacterBody2D

var body_in_range: bool = false
var _is_dead: bool = false
var _player_ref = null
var state: String = "idle"

@export_category("object")
@export var vida :int = 10000
@export var dano :int = 30
@onready var state_machine = $AnimatedSprite2D

func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body

func _on_detection_area_body_exited(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = null

func _physics_process(_delta: float) -> void:
	if _is_dead:
		return
	_animate()
	if _player_ref != null:
		if _player_ref.is_dead:
			velocity = Vector2.ZERO
			move_and_slide()
			return
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distance: float = global_position.distance_to(_player_ref.global_position)
		velocity = _direction * 75
		move_and_slide()

func _animate() -> void:
	if velocity == Vector2.ZERO:
		state = "idle"
	if velocity != Vector2.ZERO:
		if abs(velocity.x) > abs(velocity.y):
			state = "walk.x"
			if velocity.x > 0:
				state_machine.flip_h = false
			elif velocity.x < 0:
				state_machine.flip_h = true
		else:
			if velocity.y > 0:
				state = "walk.down"
			elif velocity.y < 0:
					state = "walk.up"
	state_machine.play(state)

func morte() -> void:
	_is_dead = true
	state_machine.play("death")
	await get_tree().create_timer(3).timeout
	queue_free()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func tomar_dano(Dano:int)-> void:
	vida -= Dano
	if vida <= 0:
		morte()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("character") and not _is_dead:
		body_in_range = true
		_attack_loop(body)


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		body_in_range = false

func _attack_loop(body: Node2D) -> void:
	while body_in_range and not _is_dead:
		if body.is_in_group("character") and not body.is_dead:
			body.tomar_dano(dano)
		await get_tree().create_timer(0.75).timeout
