extends Node2D

export (String) var song_name

onready var camera = $Camera2D

func _ready():
	GameState.current_level = self
	MusicController.play_song(song_name)
