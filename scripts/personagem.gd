extends CharacterBody2D

@export_range(0,10000,200) var speed:int = 400
@export var veloc_tiro = 300
@export var fire_rate :float = 0.5
var tiro = load("res://cenas/tiro.tscn")
var timer :float = 0.0
var is_dead: bool = false
var _state_machine

func movimentacao():
	var input_direction = Input.get_vector("mov_esquerda", "mov_direita", "mov_cima", "mov_baixo")
	velocity = input_direction * speed
	if is_dead:
		_state_machine.travel("death")
		return
	

#func _ready():
	#_state_machine= $StateMachine

func atirar():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer<=0:
		var instancia_tiro = tiro.instantiate()
		instancia_tiro.global_position = global_position + Vector2(0,-64).rotated(rotation)
		instancia_tiro.rotation = rotation
		instancia_tiro.direcao = Vector2.UP.rotated(rotation)
		instancia_tiro.veloc = veloc_tiro
		get_parent().add_child(instancia_tiro)
		print("tiro!")
		timer = fire_rate
	



func _physics_process(delta):
	if is_dead:
		return
	timer -= delta
	movimentacao()
	look_at(get_global_mouse_position())
	rotation += PI/2
	atirar()
	move_and_slide()


func die() -> void:
	is_dead = true
	if _state_machine:
		_state_machine.travel("death")
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
