extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $raycast
var seguindo  = "f"
var dano = 1
var gravidade =480
var contador =0  
func _ready() -> void:
	velocity.x -=50
func _physics_process(delta: float) -> void:
	if contador >0 : 
		contador-=delta
	else:
		seguindo= "f"
	if !is_on_floor():
		velocity.y+= gravidade*delta
	if is_on_floor() :
		if velocity. y > 1:
			velocity.y=0
	if velocity.y==0 :
		velocity.x=0
	if raycast.is_colliding() : 
		contador=3
		if raycast.target_position ==  Vector2(70,0) :
			seguindo="direita"
		else :
			seguindo = "esquerda"
	move_and_slide()


func _on_pulo_timeout() -> void:
		velocity.y-=150
		if  seguindo == 'f':
			velocity.x=50 *(randi() % 3 -1)
		if seguindo == "direita" :
			velocity.x = 50
		if seguindo == "esquerda" : 
			velocity.x = -50
		if velocity.x >0 :
			sprite.flip_h= true
			raycast.target_position=Vector2(70,0)
		if velocity.x<0 :
			sprite.flip_h= false
			raycast.target_position=Vector2(-70,0)
		
