extends Area2D



var forcaX = -1
var forcaY = 1
var direcao = 1
var alvo
@onready var spawn_posit: Marker2D = $"../Spawn_posit"
@onready var spawn_posit_cima: Marker2D = $"../Spawn_positCIMA"
@onready var spawn_posit_baixo: Marker2D = $"../Spawn_positBAIXO"
var eixo 
var colisor
var sugado #dps deixa isso como um array se achar melhor
var qtd_sugados : int

signal suguei#pqp esse projeto me faz usar uns nome meio gay kk

func _ready() -> void:
	monitoring = true
	monitorable = true
	

func _physics_process(delta: float) -> void:
	print("aqui o eixo", eixo)
	colisor = get_parent().colisor
	qtd_sugados = get_parent().qtd_sugados
	if alvo and not overlaps_body(alvo):
		alvo.call("interromper", true)
		alvo = null
	direcao = $"..".direcao
	print(qtd_sugados)
	if eixo != 0:
		if eixo == 1:
			global_position = spawn_posit_cima.global_position
			rotation = -90
		elif eixo == -1:
			global_position = spawn_posit_baixo.global_position
			rotation = 90
	if eixo == 0:
		global_position = spawn_posit.global_position
	if sign(spawn_posit.position.x) == -1:
		scale.x = -1
	else:
		scale.x = 1
	if Input.is_action_pressed("aspirar"):
		if colisor.is_colliding():
			if colisor.get_collider().is_in_group("inimigos") and qtd_sugados < 3:#esse 3 é o limite
				sugado = colisor.get_collider()
				emit_signal("suguei", sugado)
				colisor.get_collider().queue_free()
				
		await get_tree().physics_frame
		for body in get_overlapping_bodies():
			if body.is_in_group("inimigos"):
				alvo = body
				if alvo.has_method("interromper"):#so precaução, pd remover dps esse if, mas n oq ta dentro dele
					alvo.call("interromper", false)
			if alvo:
				alvo.global_position.x += forcaX * direcao
				if alvo.global_position.y + forcaY == spawn_posit.global_position.y or alvo.global_position.y - forcaY == spawn_posit.global_position.y:
					pass
				if alvo.global_position.y > spawn_posit.global_position.y + 1:
					alvo.global_position.y -= forcaY
				elif alvo.global_position.y < spawn_posit.global_position.y - 1:
					alvo.global_position.y += forcaY
	
	if Input.is_action_just_released("aspirar"):
		queue_free()
	

func _on_body_entered(body):
	if body.is_in_group("inimigos"):
		alvo = body
		

func _on_body_exited(body: Node2D) -> void:
	alvo.call("interromper", true)
	alvo = null
	
func _exit_tree() -> void:#caso vcs n saibam esse exit_tree é o útimo bglh q acontece antes de vc remover algo (cm queue_free)
	if alvo:
		alvo.call("interromper", true)
		alvo = null
