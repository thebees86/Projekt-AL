extends Node3D

@onready var moke = $Moke
@onready var sfx = $sfx

func explode():
	AudioServer.playback_speed_scale = 0.5
	moke.emitting = true
	sfx.play()
	await get_tree().create_timer(4.0).timeout
	queue_free()
