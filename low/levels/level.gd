extends Node2D


export (String) var song_name

func _ready():
	GameState.current_level = self
	MusicController.play_song(song_name)
