extends Node2D




const _explode = preload("res://assets/explode.wav")

# Type of gems
# gems will be spawn randomly throgh their index
@export 
var gems: Array[PackedScene]

@export 
var gameOverFroze: bool = false

@export 
var ScorePerCatch: int = 15

@onready
var _label: Label = $Label

@onready
var _audioPlayer: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var _timer: Timer = $Timer

var _score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_gem_on_game_off_screen() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	_audioPlayer.stop()
	_audioPlayer.stream = _explode
	_audioPlayer.play()
	
	__gameOverFreeze() 
	await timer.timeout
	if !gameOverFroze: __gameOverRestart()


func __gameOverRestart() -> void: 
	get_tree().reload_current_scene()
	
	
func __gameOverFreeze():
	_timer.stop()
	for c in get_children():
		c.set_process(false)
	
		
		
func __SpawnGem():
	var index = int(randf() * gems.size())
	var newGem: Gem = gems[index].instantiate() as Gem
	newGem.on_game_off_screen.connect(_on_gem_on_game_off_screen)
	newGem.position.x = randf_range(70, get_viewport_rect().size.x - 70)
	add_child(newGem)

func _on_timer_timeout() -> void:
	__SpawnGem()



func _on_paddle_area_entered(area: Area2D) -> void:
	_score += ScorePerCatch
	_label.text = "%04d" % _score
	_audioPlayer.play()
	area.queue_free()
