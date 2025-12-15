extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.global_position.x>global_position.x :
		body.dano(get_parent().dano,"inimigo esquerda")
	if body.global_position.x<global_position.x:
		body.dano(get_parent().dano,"inimigo direita")
