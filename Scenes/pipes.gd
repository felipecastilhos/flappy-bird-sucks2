extends Node2D

signal player_was_hit
signal score_area_was_reached

@export var speed: int = 400
@export_category('Pipe Setyo')
@export var bottomPipeMinLimit: int = 140
@export var bottomPipeMaxLimit: int = 140

var rng = RandomNumberGenerator.new()

var isGamePaused = false

func _ready():
	spawn_pipes()

func _process(delta: float) -> void:
	move_pipes(delta)
	free_pipes_on_left_screen()
		
func spawn_pipes():
	var spaceReducer: float = rng.randf_range(bottomPipeMinLimit, bottomPipeMaxLimit);
	position.x = 1505.0
	position.y = rng.randf_range(-360, -215)
	
	$BottomPipe.position.y -= spaceReducer
	
func move_pipes(delta: float):
	if !isGamePaused:
		var newPosition: float = position.x - speed * delta
		position.x = newPosition
	
func free_pipes_on_left_screen():
	if position.x <= -100:
		queue_free()

func on_body_collide(body):
	if body.is_in_group('player'):
		player_was_hit .emit()
		
func on_game_was_over():
	isGamePaused = true

func _on_bottom_pipe_hit_area_2d_body_entered(body):
	on_body_collide(body)

func _on_upper_pipe_hit_area_2d_body_entered(body):
	on_body_collide(body)

func _on_score_area_2d_body_entered(body):
	if body.is_in_group('player'):
		score_area_was_reached.emit()
