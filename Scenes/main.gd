extends Node

signal game_was_over

var PipesScene = preload("res://Scenes/pipes.tscn")

@onready var pipe_spawner: Timer = $PipeSpawner
@onready var game_boundaries: CollisionShape2D = $GameBoundaries/UpperLimitsShape2D3dd
@onready var foreground_layer: ParallaxLayer = $ParallaxForeground/ForegroundLayer

##### BACKGROUND #####
@onready var parallax_background:ParallaxBackground = $ParallaxBackground
@onready var backgroundLayer2: ParallaxLayer = parallax_background.get_node('BackgroundLayer2')
@onready var backgroundLayer3: ParallaxLayer = parallax_background.get_node('BackgroundLayer3')
@onready var backgroundLayer4: ParallaxLayer = parallax_background.get_node('BackgroundLayer4')

##### HUD ZONE #####
@onready var hud: CanvasLayer = $HUD
@onready var messageLabel: Label = hud.get_node('MessageLabel')
@onready var scoreCountLabel: Label = hud.get_node('ScoreCountLabel')
@onready var startButton: Button = hud.get_node('StartButton')

enum GAME_STATE { PLAYING, STOP }
@export_category('Game Configs')
@export var state: GAME_STATE = GAME_STATE.PLAYING
@export var score: float = 0
@export var scoreIncrement: int = 1
@export var gameDificultyMultiplier: float = 1

@export_category('Parallax Speed')
@export var backgroundParallaxSpeed1 = 10
@export var backgroundParallaxSpeed2 = 25
@export var backgroundParallaxSpeed3 = 25
@export var backgroundParallaxSpeed4 = 500

	
func _process(delta: float):
	scoreCountLabel.text = str(score)
	if state == GAME_STATE.PLAYING: 
		_move_parallax_background(delta)

func _move_parallax_background(delta: float):
		backgroundLayer2.motion_offset.x += delta * backgroundParallaxSpeed1
		backgroundLayer3.motion_offset.x -= delta * backgroundParallaxSpeed2
		backgroundLayer4.motion_offset.x -= delta * backgroundParallaxSpeed3
		foreground_layer.motion_offset.x -= delta * backgroundParallaxSpeed4

func _spawn_pipes():
	var pipes = PipesScene.instantiate()
	pipes.player_was_hit.connect(_on_pipes_player_was_hit)
	pipes.score_area_was_reached.connect(_on_pipes_score_area_reached)
	game_was_over.connect(pipes.on_game_was_over)

	pipes.speed += score * gameDificultyMultiplier
	pipes.bottomPipeMaxLimit += score * gameDificultyMultiplier
	add_child(pipes)
	
func _score_point():
	score += scoreIncrement
	if fmod(score, 10) == 0:
		gameDificultyMultiplier += 0.1
	
func _game_over():
	state = GAME_STATE.STOP
	pipe_spawner.stop()
	messageLabel.visible = true
	startButton.visible = true
	game_was_over.emit()
	
func _on_pipe_spawner_timeout():
	var score_ratio = score / 2
	pipe_spawner.wait_time -= 1 * score_ratio
	_spawn_pipes()

func _on_pipes_player_was_hit():
	_game_over()
	
func _on_pipes_score_area_reached():
	_score_point()
	
func _on_start_button_pressed() -> void:
	get_tree().reload_current_scene()
