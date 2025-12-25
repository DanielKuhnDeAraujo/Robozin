extends Marker2D
@onready var intervalo: Timer = $intervalo

func _ready() -> void:
	intervalo.wait_time= get_parent().tempo

func _on_intervalo_timeout() -> void:
	if get_parent().limite > 0:
		var novo_bicho = get_parent().inimigo.instantiate()
		novo_bicho.global_position = global_position
		novo_bicho.spawner = get_parent().name
		get_tree().root.get_child(0).add_child(novo_bicho)
		get_parent().limite-=1
		#meu código é lindo
