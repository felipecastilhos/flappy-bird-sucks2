extends Node

signal game_is_over

var PipesScene = preload("res://Scenes/pipes.tscn")

enum GAME_STATE { PLAYING, STOP }
var state: GAME_STATE = GAME_STATE.PLAYING
var score: int = 0

func spawn_pipes():
	var pipes = PipesScene.instantiate()
	add_child(pipes)
	pipes.hit_the_player.connect(_on_pipes_hit_the_player)
	pipes.score_area_reached.connect(_on_pipes_score_area_reached)
	
func score_point():
	score += 1
	print_debug(score)
	
func game_over():
	state = GAME_STATE.STOP
	$PipeSpawner.stop()
	$Label.visible = true
	game_is_over.emit()
	
func _on_pipe_spawner_timeout():
	spawn_pipes()

func _on_pipes_hit_the_player(): 
	game_over()
	
func _on_pipes_score_area_reached():
	score_point()
	
