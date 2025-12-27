extends Node
@onready var pai = get_parent()
func dano(qtd: int,tipo: String ) :
	pai.vida-=qtd
	if pai.vida <= 0 :
		morrer()
func morrer() : 
	if pai.spawner!= null :
		get_tree().root.get_child(0).get_node(NodePath(pai.spawner)).limite+=1
	#até a parte do get_child(0 )é pra pegar o nó inicial da cena . o resto é pra pegar o spawner e a variavel de limite dele
	get_parent().queue_free()
