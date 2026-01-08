extends Node2D
var vida = 15

func dano(qtd: int,tipo: String ) :
	vida-=qtd
	if vida <= 0 :
		morrer()
func morrer() :
	pass
