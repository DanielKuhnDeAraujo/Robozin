extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dano =1 
const SPEED = -100
const gravidade = 90

func _physics_process(delta: float) -> void:

	if !is_on_floor():
		velocity.y+= gravidade *delta
	velocity.x=SPEED
	look_at(velocity+position)
	var collision  = move_and_collide(velocity*delta)
	if !collision==null :
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free() # Replace with function body.
