extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = $"../Player"
var dano =1 
var SPEED = 0
var gravidade = 405
var subir : float  =232
var tempo
var pode_mover = true
#pra ter vida
var vida = 1
@onready var vida_inimigo: Node = $VidaInimigo
var spawner

func _ready() -> void:
	var difx : float=-( global_position.x - player.global_position.x)
	if abs(difx) < 100 : 
		subir=190
	velocity.y=-subir
	#tempo de subida 
	var t1: float = subir / gravidade
	#altura maxima
	var altura: float = subir * subir / (gravidade*2)
	var dify: float  = global_position.y - player.global_position.y
	dify=-dify
	altura += dify
	# tempo de queda
	var antesraiz =(2*altura)/gravidade
	var invert = false
	if antesraiz < 0:
		antesraiz = -antesraiz
		invert = true
	var t2 = sqrt(antesraiz)
	tempo = t1 + t2
	if invert :
		tempo -=t2
	SPEED =difx/tempo
	
func _physics_process(delta: float) -> void:
	if pode_mover :
		velocity.y+= gravidade *delta
		velocity.x=SPEED
		look_at(velocity+position)
		var collision  = move_and_collide(velocity*delta)
		if collision!=null :
			queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free() # Replace with function body.

func interromper(estado: bool) -> void:
	pode_mover = estado
