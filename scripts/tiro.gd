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
var timer_bateu =0
var destruir = 3
func _ready() -> void:
	velocity.y-=subir
	SPEED =-100
	if player.global_position.x > global_position.x :
		pass
	
func _physics_process(delta: float) -> void:
	if timer_bateu < 0.5 :
		timer_bateu -= delta
	if pode_mover :
		velocity.y+= gravidade *delta
		velocity.x=SPEED
		look_at(velocity+position)
		var collision  = move_and_collide(velocity*delta)
		if collision!=null and timer_bateu<=0 :
			velocity = velocity.bounce(collision.get_normal())
			timer_bateu = 0.1
			velocity.y += subir/4
			destruir-=1
			if destruir == 0  :
				queue_free() 


func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free() # Replace with function body.

func interromper(estado: bool) -> void:
	pode_mover = estado
