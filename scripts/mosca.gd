extends CharacterBody2D
var dano =1;
var monitorar : bool = false
func _physics_process(delta: float) -> void:
	pass
func _process(delta: float) -> void:
	pass
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	monitorar = true
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	monitorar = false
