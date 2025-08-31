extends CharacterBody2D

#cria controle no inspetor
@export var velocidade: float = 500.0


func _physics_process(delta: float) -> void:
	var vetorxy = Vector2.ZERO
	
	#inputs
	vetorxy.y = Input.get_action_strength("mov_baixo") - Input.get_action_strength("mov_cima")
	vetorxy.x = Input.get_action_strength("mov_direita") - Input.get_action_strength("mov_esquerda")
	
	#calculo da velocidade
	velocity = vetorxy.normalized()*velocidade
	move_and_slide()
