extends Node3D

@onready var moke = $Moke
@onready var sfx = $sfx

func explode():
	AudioServer.playback_speed_scale = 0.5
	moke.emitting = true
	await get_tree().create_timer(0.5).timeout
	sfx.play()
	await get_tree().create_timer(6.0).timeout
	queue_free()
