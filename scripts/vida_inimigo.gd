extends Node
var vida : int = get_parent().vida
func dano(qtd: int,tipo: String ) :
	vida-=qtd
	if vida <= 0 :
		morrer()
func morrer() : 
	queue_free()
func _ready() -> void:
	print(vida)
