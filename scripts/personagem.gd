extends CharacterBody2D

@export var speed:int = 300
@export var veloc_tiro = 300
@export var fire_rate :float = 0.5
@export var regen = 1
@export var dano = 500
var tiro = load("res://cenas/tiro.tscn")
var timer :float = 0.0
var is_dead: bool = false
var upgrades :Array = [0,0,0] #Vida,Dano,Velocd
var vida_max: float = 100
var state: String = "state"
var input_direction: Vector2 = Vector2.ZERO
@onready var vida = vida_max
@onready var state_machine = $AnimatedSprite2D

func movimentacao():
	input_direction = Input.get_vector("mov_esquerda", "mov_direita", "mov_cima", "mov_baixo")
	velocity = input_direction * speed
	if is_dead:
		return
	

#func _ready():
	#_state_machine= $StateMachine

func atirar():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer <= 0:
		var instancia_tiro = tiro.instantiate()
		var mouse_pos = get_global_mouse_position()
		var direcao = (mouse_pos - global_position).normalized()
		instancia_tiro.Dano = dano
		instancia_tiro.global_position = global_position + direcao * 42
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
	tipos_de_movimentacoes()
	state_machine.play(state)
	if vida < vida_max:
		vida += regen * delta

func atualizar(flag :int):
	if flag == 1:
		vida_max += vida_max/10 * upgrades[0]
		regen += upgrades[0] * 2
	elif flag == 2:
		dano += 500
		

func die() -> void:
	is_dead = true
	state = "death"
	state_machine.play(state)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://cenas/tela_morte.tscn")

func tipos_de_movimentacoes():
	if input_direction == Vector2.ZERO:
		state = "state"
	else:
		if abs(input_direction.x) > abs(input_direction.y):
			state = "walk_x"
			if input_direction.x > 0:
				state_machine.flip_h = false
			else:
				state_machine.flip_h = true
		else:
			if input_direction.y > 0:
				state = "walk_down"
			else:
				state = "walk_up"
				
