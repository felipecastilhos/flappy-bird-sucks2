extends RigidBody2D

@onready var animatedSprite:AnimatedSprite2D = $AnimatedSprite2D
@export var jumpForce = 350

var is_alive: bool = true

func _ready() -> void:
	animatedSprite.play()

func _process(delta: float) -> void:
	if is_alive:
		if Input.is_action_pressed('Flap'):
			linear_velocity = Vector2(0, -jumpForce)

func _on_main_game_was_over() -> void:
	is_alive = false
	animatedSprite.stop()
