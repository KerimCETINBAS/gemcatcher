extends Area2D

@export_range(40, 1200, 0.5) var speed: float = 220;
@export var ScorePerCatch: int = 10


# Moves paddle left or right
# @param delta:float delta time of the current frame
func __Move(delta: float) -> void:
	# axis between (-1, 1)
	
	var reactSizeX = get_viewport_rect().size.x
	
	var movement = position.x + delta * speed  * Input.get_axis("Left", "Right")
		
	if movement < 0:
		position.x = 0
		return
	if movement > reactSizeX:
		position.x = reactSizeX
		return
	position.x = movement
	
	
  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	__Move(delta)
