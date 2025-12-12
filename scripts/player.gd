extends CharacterBody2D
@onready var Coiote_timer = $Coiote_timer
@onready var timer_jump_buffer = $Timer_jump_buffer
@onready var timer_pulo_variável = $"Timer_pulo_variável"
@onready var label: Label = $Label
@onready var colision: CollisionShape2D = $colision
@onready var death_timer: Timer = $Death_timer
#variáveis
const SPEED: float = 250.0
const max_jump: float = -370.0
const cancela_pulo: float = 0.3
var is_jumping: bool = false
var jump_buffer: bool = false
var vida = 5
var coiote_able: bool = false

func _physics_process(delta: float) -> void:
	#jump buffer
	if jump_buffer and is_on_floor():
		pulo()
	# gravidade.
	if !is_on_floor():
		velocity += get_gravity() * delta
	# pulo
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		pulo()
	#inicia o jump buffer
	elif Input.is_action_just_pressed("pulo") and !is_on_floor():
		jump_buffer = true
		timer_jump_buffer.start()
	#se estiver pulando e largar o botão
	if Input.is_action_just_released("pulo") and is_jumping and velocity.y < 0:
		velocity.y *= cancela_pulo
		is_jumping = false
	#se não largar o botão até o fim do timer
	else:
		pass
	# input de movimento
	var direction := Input.get_axis("andar_esquerda", "andar_direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
#funções

func _on_timer_pulo_variável_timeout() -> void:
	is_jumping = false

func pulo():
	velocity.y = max_jump
	is_jumping = true

func _on_timer_jump_buffer_timeout() -> void:
	jump_buffer = false

func _on_coiote_timer_timeout() -> void:
	coiote_able = false # Replace with function body.
func dano(dano: int) :
	vida -= dano
	label.text =str(vida)
	if vida <= 0 : 
		label.text =str("Morreu!")
		Engine.time_scale=0.5
		colision.queue_free()
		death_timer.start()
		
func _on_death_timer_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()
