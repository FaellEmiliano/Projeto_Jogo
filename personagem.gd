extends CharacterBody2D

@export_range(0,10000,200) var speed:int = 400
@export var veloc_tiro = 300
@export var fire_rate = 0.5
var tiro = load("res://tiro.tscn")
var timer = 0.0

func movimentacao():
	var input_direction = Input.get_vector("mov_esquerda", "mov_direita", "mov_cima", "mov_baixo")
	velocity = input_direction * speed
	

func atirar():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer<0:
		var instancia_tiro = tiro.instantiate()
		instancia_tiro.global_position = global_position
		instancia_tiro.rotation = rotation
		instancia_tiro.direcao = Vector2.UP.rotated(rotation)
		instancia_tiro.veloc = veloc_tiro
		get_parent().add_child(instancia_tiro)
		print("tiro!")
		timer = fire_rate
	



func _physics_process(delta):
	timer-= delta
	movimentacao()
	look_at(get_global_mouse_position())
	rotation += PI/2
	atirar()
	move_and_slide()
