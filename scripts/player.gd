extends CharacterBody2D
@onready var timer_jump_buffer: Timer = $Timer_jump_buffer
@onready var timer_pulo_variável: Timer = $"Timer_pulo_variável"
@onready var colision: CollisionShape2D = $colision
@onready var death_timer: Timer = $Death_timer
@onready var timer_knock: Timer = $Timer_Knock
@onready var invulnerabilidade: Timer = $invulnerabilidade
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var spawn_posit: Marker2D = $Spawn_posit
@onready var colisor: RayCast2D = $colisor_front
@onready var main = get_tree().get_root().get_node("jogo")

#variáveis
var SPEED: float = 150.0

var MAX_SPEED: float = 200
const aceleracao: float = 15
const friccao: float = 25
const max_jump: float = -385.0
const cancela_pulo: float = 0.5
@onready var sugador = preload("res://scenes/aspirar.tscn")
@onready var projetil = preload("res://scenes/projetil.tscn")
@onready var canvas_layer = preload("res://scenes/HUD.tscn")
var HUD

var is_jumping: bool = false
var jump_buffer: bool = false
var vida: int = 5
var pulou: bool = false
var timer_coiote: float = 0
var tempo_total_coiote: float = 0.1
var knock: String = "n"
var invul: bool = false
var coiote_ativo
@export var direcao: int = -1
var pode_sugar = true
var contador = 0
var sugados
var qtd_sugados = 0
var area_aspirador
var eixo: float = 0  #determina o eixo em que o projétil vai se mover
var direction: float = 1
var spawn_projetil
var ultima_olhou: float = 1 #eu sei, é tosco, mas é necessário :(
var ammo: int = 0
var aspirando: bool = false

func _ready() -> void:
	var canvas = canvas_layer.instantiate()
	HUD = canvas.get_node("hud_root")
	main.add_child.call_deferred(canvas)
	HUD.max_life = vida
	HUD.curent_life = vida
	HUD.max_ammo = ammo
	HUD.curent_ammo = ammo
func _physics_process(delta: float) -> void:
	
	#remover depois:
	if Input.is_action_just_pressed("recarga da munião (tirar depois)"):
		ammo = 3
		atualizar()
	#obtem a posição do spawn de projétil (eu sei, tosco)
	spawn_projetil = spawn_posit.global_position
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
		if Input.is_action_just_pressed("pulo") and !aspirando:
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
	#input de visão cima/baixo:
	eixo = Input.get_axis("olhar_baixo","olhar_cima")
	# input de movimento
	direction = Input.get_axis("andar_esquerda", "andar_direita")
	if direction == 1:
		if Input.is_action_pressed("andar_direita"):
			if sign(spawn_posit.position.x) == -1: #esse position é q nem o global position so q ele é relativo ao nó pai
				spawn_posit.position.x *= -1
		if SPEED < 0:
			SPEED = 1
		SPEED = move_toward(SPEED, MAX_SPEED, aceleracao)
		velocity.x = SPEED
		sprite_2d.flip_h = false
		direcao = direction
		ultima_olhou = direction
		colisor.scale.x = direction
	elif direction == -1:
		if Input.is_action_pressed("andar_esquerda"):
			if sign(spawn_posit.position.x) == 1:
				spawn_posit.position.x *= -1
		if SPEED > 0:
			SPEED = -1
		SPEED = move_toward(SPEED, -MAX_SPEED, aceleracao)
		velocity.x = SPEED
		sprite_2d.flip_h = true
		direcao = direction
		ultima_olhou = direction
		colisor.scale.x = direction
	elif direction == 0:
		SPEED = move_toward(SPEED, 0, friccao)
		velocity.x = SPEED
		
	if Input.is_action_pressed("aspirar") and pode_sugar:
		aspirar()
		aspirando = true
		MAX_SPEED *= 0.5
		
	if Input.is_action_just_released("aspirar"):
		pode_sugar = true
		contador = 0
		aspirando = false
		MAX_SPEED /= 0.5
	
	if Input.is_action_just_pressed("atirar") and ammo > 0:
		atirar()
		if eixo != 0:
			is_jumping = false
			velocity.y = 0
			velocity.y += (300 + (70 * ammo)) * eixo 
		else:
			timer_knock.start()
			if ultima_olhou == 1:
				#velocity.x = 0
				knock = "tiroesquerda"
			elif ultima_olhou == -1:
				#velocity.x = 0
				knock = "tirodireita"
		ammo -= 1
		atualizar()
		qtd_sugados-=1
		print("Qtd sugados :",qtd_sugados)
		#knock
	if knock == "esquerda" :
		velocity.x=-290
		velocity.y=0
	if knock == "direita" :
		velocity.x=290
		velocity.y=0
	if knock == "tirodireita":
		velocity.x = 150 + (50* ammo)
	if knock == "tiroesquerda":
		velocity.x = -150 - (50* ammo)
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


func _on_coiote_timer_timeout() -> void:
	coiote_ativo = false # Replace with function body.

func dano(qtd: int,tipo: String ) :
	if not invul:
		vida -= qtd
		atualizar()
		#label.text =str(vida) + " " + str(ammo)
		label.text =str(vida) 
		if vida <= 0 : 
			#label.text =str("Morreu!")
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
	
#funcao p aspirar
func aspirar():
	pode_sugar = false
	var instance = sugador.instantiate()
	add_child(instance)
	instance.global_position = spawn_posit.global_position
	instance.scale.x = direcao
	area_aspirador = instance
	instance.suguei.connect(inimigo_sugado)

#funcao p inimigos q forem sugados
func inimigo_sugado(inimigo):
	qtd_sugados += 1 #tem q armazenar isso num array, dps algm ou eu msm boto
	sugados = true
	ammo += 1
	atualizar()
	print(inimigo.name)
	print("inimigo sugado porra")

#função do tiro:
func atirar():

	var instancia = projetil.instantiate()
	instancia.direction = ultima_olhou
	instancia.eixo =  eixo
	instancia.posicao  = spawn_projetil
	main.add_child.call_deferred(instancia)

func atualizar():
	HUD.atualizar = true
	HUD.curent_ammo = ammo
	HUD.curent_life = vida
	HUD.curent_ammo = ammo
	
