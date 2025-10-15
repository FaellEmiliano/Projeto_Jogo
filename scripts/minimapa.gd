extends SubViewport
@onready var cam = $Camera2D
@export var jogador = CharacterBody2D

func _physics_process(_delta: float) -> void:
	cam.position = owner.find_child("jogador").position
