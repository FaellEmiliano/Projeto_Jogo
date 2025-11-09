extends Node2D

signal seta_ativada(seta)
var pode_pegar = false
var player_ref = null

@onready var vel = $AnimatedSprite2D
@onready var dano = $AnimatedSprite2D
@onready var vida = $AnimatedSprite2D

func _ready() -> void:
	vel.play("default")
	dano.play("default")
	vida.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		pode_pegar = true
		player_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		pode_pegar = false
		player_ref = null

func _process(_delta: float) -> void:
	if pode_pegar and Input.is_action_just_pressed("Pegar_item"):
		print(self.name)
		if self.name == "Upgrade_Vida":
			print("vida")
			player_ref.upgrades[0] += 1
			upgrade.atualizar(1)
			player_ref.atualizar()
		elif self.name == "Upgrade_Dano":
			print("dano")
			player_ref.upgrades[1] += 1
			upgrade.atualizar(2)
			player_ref.atualizar()
		elif self.name == "Upgrade_Veloc":
			print("velocidade")
			player_ref.upgrades[2] += 1 
			upgrade.atualizar(3)
			player_ref.atualizar()
		
		print(player_ref.upgrades)
		seta_ativada.emit(self)
		queue_free()
