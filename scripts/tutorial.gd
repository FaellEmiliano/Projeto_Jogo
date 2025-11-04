extends Node2D


func _ready() -> void:
	var sala_tutorial = $Sala_tutorial
	var sala = $Sala
	var upgrades = $Sala_Segura
	sala_tutorial.vizinhos_instanciados = ["N"]
	sala.vizinhos_instanciados = ["N", "S"]
	upgrades.vizinhos_instanciados = ["N", "S"]
