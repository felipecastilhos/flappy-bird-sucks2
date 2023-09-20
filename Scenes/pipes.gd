extends Node2D

@export var speed = 400
var rng = RandomNumberGenerator.new()

func _ready():
	position.x = 1505.0
	position.y = rng.randf_range(-294, 42)
	scale = Vector2(3.412, 2.44)

func _process(delta: float) -> void:
	var newPosition: float = position.x - speed * delta
	position.x = newPosition
	
	if position.x <= -100:
		queue_free()
