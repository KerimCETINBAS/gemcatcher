class_name Gem extends Area2D


@export var speed: float = 60;


signal on_game_off_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func __Move(delta: float):
	position.y += delta * speed
	if position.y >  get_viewport_rect().size.y: 
		on_game_off_screen.emit()
		set_process(false)
		queue_free()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	__Move(delta)
