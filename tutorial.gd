extends Node2D
func _ready():
	var _sala=$Sala_tutorial
	var _sala2=$Sala2
	_sala.vizinhos_instanciados=["N"]
	_sala2.vizinhos_instanciados=["N","S"]
