extends Area2D

@onready var timer: Timer = $Timer
var dentro =false
var timer_invul=0
var bode
func _on_body_entered(body: Node2D) -> void:
	dentro= true
	bode =body
	if body.global_position.x>global_position.x :
		body.dano(get_parent().dano,"inimigo esquerda")
	if body.global_position.x<global_position.x:
		body.dano(get_parent().dano,"inimigo direita")
func _physics_process(delta: float) -> void:
	if dentro : 
		if not bode.invul  :
			timer_invul+=1*delta
			if timer_invul>=0.2 : 
				timer_invul=0
				if bode.global_position.x>global_position.x :
					bode.dano(get_parent().dano,"inimigo esquerda")
				if bode.global_position.x<global_position.x:
					bode.dano(get_parent().dano,"inimigo direita")
		


func _on_body_exited(_body: Node2D) -> void:
	dentro =false
