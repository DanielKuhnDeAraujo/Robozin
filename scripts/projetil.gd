extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D

var posicao
var velocidade: float = 1000
var direction: float
var eixo: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	global_position = posicao
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if eixo == 0:
		velocity.x += velocidade * direction * delta
	elif eixo == 1 or eixo == -1:
		velocity.y += velocidade * -eixo * delta
	var collision = move_and_collide(velocity*delta)
	if collision !=null :
		queue_free()
		

func _on_timer_timeout() -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.vida_inimigo.dano(1,"...")
	queue_free()
