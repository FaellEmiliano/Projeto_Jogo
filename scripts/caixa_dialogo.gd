extends MarginContainer

@onready var delay: Timer = $delay
@onready var texto: Label = $MarginContainer/texto

const tamanho_max = 256
var text := ""
var indice = 0

var letter_display_timer := 0.02
var space_display_timer := 0.03
var pontuacao_display_timer := 0.07

signal texto_finalizado()

func display_text(texto_para_digitar: String):
	text = texto_para_digitar
	texto.text = texto_para_digitar
	
	await resized
	
	custom_minimum_size.x = min(size.x, tamanho_max)
	
	if size.x > tamanho_max:
		texto.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x /2
	global_position.y -= size.y + 24
	texto.text = ""
	display_letra()

func display_letra(): 
	texto.text += text[indice]
	indice += 1
	
	if indice >= text.length():
		texto_finalizado.emit()
		return
		
	match text[indice]:
		"!","?",",",".":
			delay.start(pontuacao_display_timer)
		" ":
			delay.start(space_display_timer)
		_:
			delay.start(letter_display_timer)

func _on_delay_timeout() -> void:
	display_letra()
