extends Marker2D
@onready var intervalo: Timer = $intervalo
func _ready() -> void:
	intervalo.wait_time= get_parent().tempo

func _on_intervalo_timeout() -> void:
	var novo_bicho = get_parent().inimigo.instantiate()
	novo_bicho.global_position = global_position
	
