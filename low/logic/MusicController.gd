extends Node

export var default_volume = -24.0

var sad_song = load("res://assets/sound/sad_song.ogg")
var happy_song = load("res://assets/sound/happy_song.ogg")

func play_song(song_name: String):
	match song_name:
		"sad":
			play(sad_song, default_volume)
		"happy":
			play(happy_song, default_volume)


func play(song, volume):
	if not $AudioStreamPlayer.playing or not $AudioStreamPlayer.stream == song:
		$AudioStreamPlayer.stream = song
		$AudioStreamPlayer.volume_db = volume
		$AudioStreamPlayer.play()

func set_volume(volume):
	$AudioStreamPlayer.volume_db = volume
