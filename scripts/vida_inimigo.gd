extends Node
@onready var pai = get_parent()
func dano(qtd: int,tipo: String ) :
	pai.vida-=qtd
	if pai.vida <= 0 :
		morrer()
func morrer() : 
	get_parent().queue_free()
