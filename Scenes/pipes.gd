extends Node2D

@export var speed = 400

func _process(delta: float) -> void:
	var newPosition: float = position.x - speed * delta
	position.x = newPosition

