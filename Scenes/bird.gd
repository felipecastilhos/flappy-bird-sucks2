extends RigidBody2D

var is_dead: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	if is_dead:
		linear_velocity = Vector2(0, 350)
	else:
		if Input.is_action_pressed('Flap'):
			linear_velocity = Vector2(0, -350)
	
	collision_layer = 0 if is_dead else 1
