extends Node2D

@onready var player: CharacterBody2D = %Player
@onready var hud: Control = $Hud/hud_root

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.atualizar_hud.connect(hud.atualizar())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_atualizar_hud(vida: int, ammo: int) -> void:
	hud.curent_ammo = ammo
	hud.curent_life = vida
