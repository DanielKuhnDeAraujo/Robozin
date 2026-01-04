extends Area2D


var dentro =false
var timer_invul=0
var bode
var atacar = true
func _on_body_entered(body: Node2D) -> void:
	if atacar:
		dentro= true
		bode =body
		if body.global_position.x>global_position.x :
			body.dano(get_parent().dano,"inimigo esquerda")
		if body.global_position.x<global_position.x:
			body.dano(get_parent().dano,"inimigo direita")
func _physics_process(delta: float) -> void:
	causar_dano()
	if atacar:
		if dentro : 
			if not bode.invul  :
				timer_invul+=1*delta
				if timer_invul>=0.2 : 
					timer_invul=0
					if bode.global_position.x > global_position.x :
						bode.dano(get_parent().dano,"inimigo esquerda")
					if bode.global_position.x < global_position.x:
						bode.dano(get_parent().dano,"inimigo direita")
		


func _on_body_exited(_body: Node2D) -> void:
	dentro =false

#sistema provisório, trocar quando precisar (assim q der)
func causar_dano():
	if get_parent().has_method("interromper"):
		atacar = get_parent().pode_mover
