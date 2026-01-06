extends Control
var ammo: int
var hp: int
var last_ammo: int = 3
var last_hp: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pausa"):
		if get_tree().paused:
			get_tree().paused = false
			visible = false
		else:
			visible = true
			get_tree().paused = true
		
