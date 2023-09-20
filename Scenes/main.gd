extends Node2D

var PipesScene = preload("res://Scenes/pipes.tscn")

func _on_pipe_spawner_timeout():
	add_child(PipesScene.instantiate())
	
