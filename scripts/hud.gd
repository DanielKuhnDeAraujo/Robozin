extends Control

var max_life: int
var max_ammo: int
var curent_life: int
var curent_ammo: int
@onready var barra_municao: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer2/barra_municao
@onready var barra_vida: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer/barra_vida

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func atualizar() -> void:
	barra_vida.value = curent_life
	barra_municao.value = curent_ammo
