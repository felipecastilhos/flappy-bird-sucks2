extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _process(delta) -> void:
	if shakeFade > 0.1:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		offset = random_offset()
	
func apply_shake() -> void:
	shake_strength = randomStrength


func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func _on_main_game_was_over() -> void:
	apply_shake()
