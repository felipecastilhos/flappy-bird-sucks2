extends Node

var PipesScene = preload("res://Scenes/pipes.tscn")

enum GAME_STATE { PLAYING, STOP }
var state: GAME_STATE = GAME_STATE.PLAYING

func spawn_pipes():
	var pipes = PipesScene.instantiate()
	add_child(pipes)
	pipes.hit_the_player.connect(_on_pipes_hit_the_player)
		
func game_over():
	state = GAME_STATE.STOP
	$PipeSpawner.stop()
	print_debug("game over")

func _on_pipe_spawner_timeout():
	spawn_pipes()

func _on_pipes_hit_the_player(): 
	game_over()
	
