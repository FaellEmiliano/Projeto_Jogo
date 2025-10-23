extends SubViewport
@onready var cam = $Camera2D
@export var jogador = CharacterBody2D
@onready var mapa = $TileMapLayer

func _physics_process(_delta: float) -> void:
	cam.position = mapa.position + Vector2(320,320)
	
