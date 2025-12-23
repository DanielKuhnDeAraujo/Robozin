extends CharacterBody2D
var dano =1;
var monitorar : bool = false
var bode
var speed : int = 25
var pode_mover = true

func _physics_process(delta: float) -> void:
	if pode_mover:
		if monitorar :
			if bode.global_position.x < global_position.x :
				velocity.x=-speed
			else : 
				velocity.x=speed
			if bode.global_position.y < global_position.y :
				velocity.y=-speed
			else : 
				velocity.y=speed
		else :
			velocity= Vector2(0,0)
		move_and_slide()
func _process(delta: float) -> void:
	pass
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	monitorar = true
	bode = body
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	monitorar = false


func interromper(estado: bool) -> void:
	pode_mover = estado
	
