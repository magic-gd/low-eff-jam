extends TextureButton

export (Texture) var on_texture
export (Texture) var off_texture

var sound_off = false

func _ready():
	connect("pressed", self, "_on_pressed")

func _on_pressed():
	sound_off = !sound_off
	texture_normal = off_texture if sound_off else on_texture
	var volume = -80 if sound_off else -12
	MusicController.set_volume(volume)
