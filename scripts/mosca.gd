extends CharacterBody2D
var dano =1;
var vida =1;
var monitorar : bool = false
var bode
var speed : int = 75
var pode_mover = true
var random: int
var dir_random_list  = ["-y","y","x","-x"]
var dir_random = "y"
var dir_random_d = "x"
@onready var move_random: Timer = $Move_random

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
		if dir_random == "y" or dir_random_d =="y":
			velocity.y += speed /3
		if dir_random == "-y" or dir_random_d =="-y":
			velocity.y -= speed /3
		if dir_random == "x" or dir_random_d =="x":
			velocity.x += speed /3
		if dir_random == "-x" or dir_random_d =="-x":
			velocity.x -= speed /3
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
	


func _on_move_random_timeout() -> void:
	random = randi() % 4
	dir_random = dir_random_list[random]
	random = randi() % 4
	dir_random_d = dir_random_list[random]
	 
