extends Node2D

signal playerHitAPipe

@export var speed: int = 400
var rng = RandomNumberGenerator.new()

const hardMaxPipeReducer: int = 180 #todo: use this based on score
const mediumPipeSpacerReducer: int = 140

func _ready():
	spawn_pipes()

func _process(delta: float) -> void:
	move_pipes(delta)
	free_pipes_on_left_screen()
		
func spawn_pipes():
	var pipeSpacerReducer: int = rng.randf_range(40, mediumPipeSpacerReducer);
	position.x = 1505.0
	position.y = rng.randf_range(-360, -215)
	
	$BottomPipe.position.y -= pipeSpacerReducer
	
	
func move_pipes(delta: float):
	var newPosition: float = position.x - speed * delta
	position.x = newPosition
	
func free_pipes_on_left_screen():
	if position.x <= -100:
		queue_free()


func _on_bottom_pipe_area_2d_body_entered(body):
	on_body_collide(body)


func _on_upper_pipe_area_2d_body_entered(body):
	on_body_collide(body)
	
func on_body_collide(body):
	if body.is_in_group('player'):
		print_debug('hit on pipe')	
