extends Node

signal game_is_over

var PipesScene = preload("res://Scenes/pipes.tscn")

enum GAME_STATE { PLAYING, STOP }
var state: GAME_STATE = GAME_STATE.PLAYING
var score: int = 0

func _process(delta):
	$HUD/ScoreCountLabel.text = str(score)
 
func spawn_pipes():
	var pipes = PipesScene.instantiate()
	pipes.speed += score
	pipes.pipeSpaceReducer += score
	print_debug("Pipe speed: " + str(pipes.speed))
	add_child(pipes)
	pipes.hit_the_player.connect(_on_pipes_hit_the_player)
	pipes.score_area_reached.connect(_on_pipes_score_area_reached)
	
func score_point():
	score += 1
	
func game_over():
	state = GAME_STATE.STOP
	$PipeSpawner.stop()
	$HUD/MessageLabel.visible = true
	$HUD/StartButton.visible = true
	game_is_over.emit()
	
func _on_pipe_spawner_timeout():
	var score_ratio = score / 2
	print_debug("Score ratio: " + str(score_ratio))
	$PipeSpawner.wait_time -= 1 * score_ratio
	spawn_pipes()

func _on_pipes_hit_the_player():
	game_over()
	
func _on_pipes_score_area_reached():
	score_point()
	
func _on_start_button_pressed() -> void:
	get_tree().reload_current_scene()
