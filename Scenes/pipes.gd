extends Node2D

@export var speed: int = 400
var rng = RandomNumberGenerator.new()

const hardMaxPipeReducer: int = 180 #todo: use this based on score
const mediumPipeSpacerReducer: int = 140

func _ready():
	var pipeSpacerReducer: int = rng.randf_range(40, mediumPipeSpacerReducer);
	position.x = 1505.0
	position.y = rng.randf_range(-360, -215)
	
	$BottomPipe.position.y -= pipeSpacerReducer

func _process(delta: float) -> void:
	var newPosition: float = position.x - speed * delta
	position.x = newPosition
	
	if position.x <= -100:
		queue_free()
