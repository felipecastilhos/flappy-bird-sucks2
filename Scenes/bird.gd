extends RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	if Input.is_action_pressed('Flap'):
		linear_velocity = Vector2(0, -350)
