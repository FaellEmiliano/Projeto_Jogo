extends CharacterBody2D

@export var speed:int = 300
@export var veloc_tiro = 300
@export var fire_rate :float = 0.5
var tiro = load("res://cenas/tiro.tscn")
var timer :float = 0.0
var is_dead: bool = false
var _state_machine
var upgrades :Array = [0,0,0] #Vida,Dano,Veloc
var vida_max = 100
@onready var vida = vida_max

func movimentacao():
	var input_direction = Input.get_vector("mov_esquerda", "mov_direita", "mov_cima", "mov_baixo")
	velocity = input_direction * speed
	if is_dead:
		_state_machine.travel("death")
		return
	

#func _ready():
	#_state_machine= $StateMachine

func atirar():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer <= 0:
		var instancia_tiro = tiro.instantiate()
		var mouse_pos = get_global_mouse_position()
		var direcao = (mouse_pos - global_position).normalized()
		instancia_tiro.global_position = global_position + direcao * 64
		instancia_tiro.rotation = direcao.angle()
		instancia_tiro.direcao = direcao
		instancia_tiro.veloc = veloc_tiro
		get_parent().add_child(instancia_tiro)
		print("tiro!")
		timer = fire_rate
	

func tomar_dano(dano :float):
	vida -= dano
	if vida <= 0:
		die()

func _physics_process(delta):
	if is_dead:
		return
	timer -= delta
	movimentacao()
	atirar()
	move_and_slide()
	if vida < vida_max:
		vida += 1 *delta

func atualizar():
	vida_max += vida_max/10 * upgrades[0]

func die() -> void:
	is_dead = true
	if _state_machine:
		_state_machine.travel("death")
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
