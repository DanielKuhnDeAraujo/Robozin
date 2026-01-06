extends CanvasLayer

var active: int = 0
@onready var retornar: Button = $PanelContainer/MarginContainer/VBoxContainer/retornar
@onready var sair: Button = $PanelContainer/MarginContainer/VBoxContainer/sair
@onready var configs: Button = $PanelContainer/MarginContainer/VBoxContainer/configs
signal atualizar
signal ativar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pausa"):
		emit_signal("ativar")
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			get_tree().paused = true
			visible = true
	
	#if Input.is_action_just_pressed("olhar_baixo"):
		#if active < 3:
			#active += 1
		#else:
			#active = 1
	#if Input.is_action_just_pressed("olhar_cima"):
		#if active > 1:
			#active -= 1
		#else:
			#active = 3
	#print(active)
func _on_retornar_pressed() -> void:
	visible = false
	get_tree().paused = false



#func _on_ativar() -> void:
	#if active == 0:
		#visible = false
		#get_tree().paused = false
	#elif  active == 1:
		#visible = false
		#get_tree().paused = false
	#elif  active == 2:
		#print("estamos trabalhando nisso!")
	#elif active == 3:
		#get_tree().change_scene_to_file("res://scenes/Tela inicial.tscn")


func _on_configs_pressed() -> void:
	print("estamos trabalhando nisso!")


func _on_sair_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Tela inicial.tscn")
