extends Node2D

signal seta_ativada(seta)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print(self.name)
	if self.name == "Upgrade_Vida":
		print("vida")
		_body.upgrades[0] += 1
	if self.name == "Upgrade_Dano":
		print("dano")
		_body.upgrades[1] += 1
	if self.name == "Upgrade_Veloc":
		print("velocidade")
		_body.upgrades[2] += 1
	print(_body.upgrades)
	if _body.is_in_group("character"):
		seta_ativada.emit(self)
	_body.atualizar()
