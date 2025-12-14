extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		if body.position.x>position.x :
			body.dano(get_parent().dano,"inimigo direita")
		if body.position.x<position.x :
			body.dano(get_parent().dano,"inimigo esquerda")
