extends Node
@onready var pai = get_parent()
func dano(qtd: int,tipo: String ) :
	pai.vida-=qtd
	if pai.vida <= 0 :
		morrer()
func morrer() : 
	queue_free()
func _ready() -> void:
	print(pai.vida)
