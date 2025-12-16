extends CharacterBody2D
@onready var timer_jump_buffer: Timer = $Timer_jump_buffer
@onready var timer_pulo_variável: Timer = $"Timer_pulo_variável"
@onready var label: Label = $Label
@onready var testes: Label = $testes
@onready var colision: CollisionShape2D = $colision
@onready var death_timer: Timer = $Death_timer
@onready var timer_knock: Timer = $Timer_Knock
@onready var invulnerabilidade: Timer = $invulnerabilidade
@onready var sprite_2d: Sprite2D = $Sprite2D
#variáveis
const SPEED: float = 250.0
const max_jump: float = -385.0
const cancela_pulo: float = 0.3
var is_jumping: bool = false
var jump_buffer: bool = false
var vida = 5
var pulou: bool = false
var timer_coiote: float = 0
var tempo_total_coiote: float = 0.1
var knock = "n"
var invul = false

func _physics_process(delta: float) -> void:
	#testes
	#jump buffer
	if jump_buffer and is_on_floor():
		pulo()
	# checks fora do chão
	if !is_on_floor():
		#gravidade
		timer_coiote -= delta
		velocity += get_gravity() * delta
		# se não pulou ativa o coiote
		if pulou:
			timer_coiote = 0
		# se está fora do chão e o coiote_ativo == able, ele permite pular 
		if Input.is_action_just_pressed("pulo") and timer_coiote > 0:
			pulo()
	#reinicia o coiote time
	if is_on_floor():
		pulou = false
		timer_coiote = tempo_total_coiote
		# pulo
		if Input.is_action_just_pressed("pulo"):
			pulo()
			pulou = true
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
		#knock
	if knock == "esquerda" :
		velocity.x=-290
		velocity.y=0
	if knock == "direita" :
		velocity.x=290
		velocity.y=0
	move_and_slide()
	
	
#funções

func _on_timer_pulo_variável_timeout() -> void:
	is_jumping = false

func pulo():
	velocity.y = max_jump
	is_jumping = true
	pulou = true
	timer_coiote = 0

func _on_timer_jump_buffer_timeout() -> void:
	jump_buffer = false

func dano(dano: int) :
	vida -= dano
	label.text =str(vida)
	if vida <= 0 : 
		label.text =str("Morreu!")
		Engine.time_scale=0.5
		colision.queue_free()
		death_timer.start()
func _on_coiote_timer_timeout() -> void:
	coiote_ativo = false # Replace with function body.

func dano(dano: int,tipo: String) :
	if not invul:
		vida -= dano
		label.text =str(vida)
		if vida <= 0 : 
			label.text =str("Morreu!")
			Engine.time_scale=0.5
			colision.queue_free()
			death_timer.start()
		else :
			invulnerabilidade.start()
			sprite_2d.modulate.a =0.5
			invul= true
			if tipo == "inimigo esquerda" :
				knock="direita"
			if tipo == "inimigo direita" :
				knock="esquerda"
			timer_knock.start()
		
func _on_death_timer_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()


func _on_timer_knock_timeout() -> void:
	knock = "n"


func _on_invulnerabilidade_timeout() -> void:
	sprite_2d.modulate.a =1
	invul=false # Replace with function body.
