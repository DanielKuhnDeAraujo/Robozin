extends Area2D



var forcaX = -1
var forcaY = 1
var direcao = 1
var alvo
var dentro
@onready var spawn_posit: Marker2D = $"../Spawn_posit"
var colisor
var sugado #dps deixa isso como um array se achar melhor
var qtd_sugados : int
var inimigos := []



signal suguei#pqp esse projeto me faz usar uns nome meio gay kk

func _ready() -> void:
	monitoring = true
	monitorable = true
	

func _physics_process(delta: float) -> void:
	qtd_sugados = get_parent().qtd_sugados
	colisor = get_parent().colisor
	colisor.monitoring = true

	if alvo and not overlaps_body(alvo):
		alvo.call("interromper", true)
		alvo = null
	direcao = $"..".direcao
	global_position = spawn_posit.global_position
	if sign(spawn_posit.position.x) == -1:
		scale.x = -1
	else:
		scale.x = 1
	
	if Input.is_action_pressed("aspirar"):
		
		for algo in colisor.get_overlapping_bodies():
			if algo.is_in_group("inimigos"):
				dentro = colisor.get_overlapping_bodies()
				inimigos.append(algo)
				
				if alvo in dentro and qtd_sugados < 3:
					var sugado = alvo
					emit_signal("suguei", sugado)
					alvo.vida_inimigo.morrer()
					
		for body in get_overlapping_bodies():
			if body.is_in_group("inimigos"):
				alvo = body
				if alvo.has_method("interromper"):#so precaução, pd remover dps esse if, mas n oq ta dentro dele
					alvo.call("interromper", false)
			if alvo:
				
				alvo.global_position.x += forcaX * direcao
				if alvo.global_position.y + forcaY == spawn_posit.global_position.y or alvo.global_position.y - forcaY == spawn_posit.global_position.y:
					pass
				elif alvo.global_position.y > spawn_posit.global_position.y + 1:
					alvo.global_position.y -= forcaY
				elif alvo.global_position.y < spawn_posit.global_position.y - 1:
					alvo.global_position.y += forcaY
					
	
	if Input.is_action_just_released("aspirar"):
		queue_free()

"""func _on_body_entered(body):
	if body.is_in_group("inimigos"):
		if body.has_method("interromper"): 
			body.call("interromper", false)"""


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("interromper") : 
		body.call("interromper", true)
		
	
func _exit_tree() -> void:#caso vcs n saibam esse exit_tree é o útimo bglh q acontece antes de vc remover algo (cm queue_free)
	if alvo:
		alvo.call("interromper", true)
		alvo = null
