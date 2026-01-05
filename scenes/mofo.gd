extends StaticBody2D
#Necessário pra vida
var vida = 5
@onready var vida_inimigo: Node = $VidaInimigo
var spawner
#pra dar dano quando enconstar nele
var dano = 1
var tiro_cena = preload("res://scenes/tiro.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawner_timeout() -> void:
	var novo_bicho = tiro_cena.instantiate()
	novo_bicho.global_position = global_position
	novo_bicho.global_position.y -= 50
	get_tree().root.get_child(0).add_child(novo_bicho)
