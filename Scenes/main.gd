extends Node

signal game_was_over

var PipesScene = preload("res://Scenes/pipes.tscn")

@onready var parallaxBackground:ParallaxBackground = $ParallaxBackground
@onready var hud: CanvasLayer = $HUD
@onready var foregroundLayer: ParallaxLayer = $ParallaxForeground/ForegroundLayer
@onready var pipeSpawner: Timer = $PipeSpawner

@onready var messageLabel: Label = hud.get_node('MessageLabel')
@onready var scoreCountLabel: Label = hud.get_node('ScoreCountLabel')
@onready var startButton: Button = hud.get_node('StartButton')
@onready var backgroundLayer2: ParallaxLayer = parallaxBackground.get_node('BackgroundLayer2')
@onready var backgroundLayer3: ParallaxLayer = parallaxBackground.get_node('BackgroundLayer3')
@onready var backgroundLayer4: ParallaxLayer = parallaxBackground.get_node('BackgroundLayer4')


enum GAME_STATE { PLAYING, STOP }
@export_category('Game Configs')
@export var state: GAME_STATE = GAME_STATE.PLAYING
@export var score: int = 0
@export var scoreIncrement: int = 1

@export_category('Parallax Speed')
@export var backgroundParallaxSpeed1 = 10
@export var backgroundParallaxSpeed2 = 25
@export var backgroundParallaxSpeed3 = 25
@export var backgroundParallaxSpeed4 = 500

	
func _process(delta: float):
	scoreCountLabel.text = str(score)
	var parallaxLayer1
	
	if state == GAME_STATE.PLAYING: 
		move_parallax_background(delta)

func move_parallax_background(delta: float):
		backgroundLayer2.motion_offset.x += delta * backgroundParallaxSpeed1
		backgroundLayer3.motion_offset.x -= delta * backgroundParallaxSpeed2
		backgroundLayer4.motion_offset.x -= delta * backgroundParallaxSpeed3
		foregroundLayer.motion_offset.x -= delta * backgroundParallaxSpeed4

func spawn_pipes():
	var pipes = PipesScene.instantiate()
	pipes.speed += score
	pipes.pipeSpaceReducer += score
	add_child(pipes)
	pipes.player_was_hit.connect(_on_pipes_player_was_hit)
	pipes.score_area_was_reached.connect(_on_pipes_score_area_reached)
	
func score_point():
	score += scoreIncrement
	
func game_over():
	state = GAME_STATE.STOP
	pipeSpawner.stop()
	messageLabel.visible = true
	startButton.visible = true
	game_was_over.emit()
	
func _on_pipe_spawner_timeout():
	var score_ratio = score / 2
	pipeSpawner.wait_time -= 1 * score_ratio
	spawn_pipes()

func _on_pipes_player_was_hit():
	game_over()
	
func _on_pipes_score_area_reached():
	score_point()
	
func _on_start_button_pressed() -> void:
	get_tree().reload_current_scene()
