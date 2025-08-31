extends CharacterBody2D

#cria controle no inspetor
@export var velocidade: float = 500.0
@export var tiro: PackedScene
@export var fire_rate: float = 1
var fire_timer = 0.0

func _physics_process(delta: float) -> void:
	var vetorxy = Vector2.ZERO
	
	#inputs
	vetorxy.y = Input.get_action_strength("mov_baixo") - Input.get_action_strength("mov_cima")
	vetorxy.x = Input.get_action_strength("mov_direita") - Input.get_action_strength("mov_esquerda")
	look_at(get_global_mouse_position())
	rotation += PI/2
	
	#calculo da velocidade
	velocity = vetorxy.normalized()*velocidade
	move_and_slide()
	
	#tiro
	fire_timer -= delta
	if fire_timer <= 0:
		var bala = tiro.instantiate()
		bala.z_index = -1
		bala.position = position + Vector2(0,-50).rotated(rotation)
		bala.direcao = rotation
		bala.direcao = Vector2.UP.rotated(rotation)
		get_parent().add_child(bala)
		fire_timer = fire_rate
	
	
	
	
