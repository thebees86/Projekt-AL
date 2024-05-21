extends Node3D

#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0

var noclip_timer
var collision_shape
var in_motion = false

@onready var flight_path = $FlightPath
@onready var path_follow_3d = $FlightPath/PathFollow3D

func _ready():
	collision_shape = $FlightPath/PathFollow3D/Projectile/projectile_collision
	collision_shape.disabled = true
	#noclip_timer = $noclip_timer
	#noclip_timer.start(0.5)

func fire():
	in_motion = true

func _physics_process(delta):
	if in_motion:
		collision_shape = $FlightPath/PathFollow3D/Projectile/projectile_collision
		collision_shape.position = path_follow_3d.global_position
		collision_shape.rotation = path_follow_3d.rotation
		
		if path_follow_3d.progress_ratio + 0.2 * delta < 1:
				path_follow_3d.progress_ratio += delta
