extends CharacterBody2D

var _is_dead: bool = false
var _player_ref  = null

@export_category("object")
@export var vida :int = 25000
@export var dano :int = 100
var tiro = load("res://cenas/tiro_esqueleto.tscn")
var timer :float = 0.0
@export var fire_rate :float = 1.5
@export var veloc_tiro = 270
var state = "idle"
@onready var state_machine = $AnimatedSprite2D

func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body
		
		
func _on_detection_area_body_exited(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = null
		
func _physics_process(delta: float) -> void:
	timer -= delta
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
		velocity = _direction * 200
		if _distance > 300:
			move_and_slide()
		else:
			atirar(_direction)
		
func atirar(direcao : Vector2):
	if timer <= 0:
		var instancia_tiro = tiro.instantiate()
		instancia_tiro.global_position = global_position + direcao * 64
		instancia_tiro.rotation = direcao.angle()
		instancia_tiro.direcao = direcao
		instancia_tiro.veloc = veloc_tiro
		instancia_tiro.Dano = dano
		get_tree().current_scene.add_child(instancia_tiro)
		timer = fire_rate


func _animate() -> void:
	if velocity == Vector2.ZERO:
		state = "idle"
	if velocity != Vector2.ZERO:
		if abs(velocity.x) > abs(velocity.y):
			state = "walk_x"
			if velocity.x > 0:
				state_machine.flip_h = false
			elif velocity.x < 0:
				state_machine.flip_h = true
		else:
			if velocity.y > 0:
				state = "walk_down"
			elif velocity.y < 0:
					state = "walk_up"
	state_machine.play(state)

func morte() -> void:
	_is_dead = true
	state_machine.play("death")
	queue_free()
	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func tomar_dano(Dano:int)-> void:
	vida -= Dano
	if vida <= 0:
		morte()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		body.tomar_dano(dano)
