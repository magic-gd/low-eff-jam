extends Node

export var default_volume = -12.0

var sad_song = preload("res://assets/sound/sad_song.ogg")
var happy_song = preload("res://assets/sound/happy_song.ogg")
var fight_song = preload("res://assets/sound/fight_song.wav")

var jump_effect = preload("res://assets/sound/effects/jump.wav")
var complete_effect = preload("res://assets/sound/effects/complete.wav")

func play_song(song_name: String):
	match song_name:
		"sad":
			play(sad_song, default_volume)
		"happy":
			play(happy_song, default_volume)
		"fight":
			play(fight_song, default_volume)


func play(song, volume):
	if not $AudioStreamPlayer.playing or not $AudioStreamPlayer.stream == song:
		$AudioStreamPlayer.stream = song
		$AudioStreamPlayer.volume_db = volume
		$AudioStreamPlayer.play()

func play_effect(effect):
	$EffectPlayer.volume_db = default_volume
	match effect:
		"jump":
			$EffectPlayer.stream = jump_effect
			$EffectPlayer.play()
		"complete":
			$EffectPlayer.stream = complete_effect
			$EffectPlayer.play()

func set_volume(volume):
	default_volume = volume
	$AudioStreamPlayer.volume_db = volume
	$EffectPlayer.volume_db = volume
