extends Node

var sad_song = load("res://assets/sound/sad_song.ogg")
var happy_song = load("res://assets/sound/happy_song.ogg")

func play_song(song_name: String):
	match song_name:
		"sad":
			$AudioStreamPlayer.stream = sad_song
			$AudioStreamPlayer.volume_db = -12
		"happy":
			$AudioStreamPlayer.stream = happy_song
			$AudioStreamPlayer.volume_db = -12
	
	$AudioStreamPlayer.play()
	
