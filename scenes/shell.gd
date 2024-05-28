extends Node3D

#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0

var noclip_timer
var collision_shape
var in_motion = false

var flight_path


func _ready():
	collision_shape = $Projectile/projectile_collision
	collision_shape.disabled = true
	#noclip_timer = $noclip_timer
	#noclip_timer.start(0.5)

func fire(path):
	in_motion = true

func _physics_process(delta):
	if in_motion:
		var path_follow_3d = flight_path.path_follow_3d
		if path_follow_3d.progress_ratio + 0.2 * delta < 1:
				path_follow_3d.progress_ratio += delta
