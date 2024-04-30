extends RigidBody3D

#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 3
var launch_vel = 20
var velocity = Vector3(0, 0, 0)
var rot_velocity = Vector3(0, 0, 0)

var noclip_timer
var collision_shape


func _ready():
	collision_shape = $projectile_collision
	collision_shape.disabled = true
	#noclip_timer = $noclip_timer
	#noclip_timer.start(0.5)
	velocity.x = (rotation.x+1) * launch_vel
	velocity.y = (rotation.y) * launch_vel
	velocity.z = (rotation.z) * launch_vel

func _physics_process(delta):
	velocity.y -= gravity * delta
	position += velocity * delta
	#if noclip_timer.is_stopped:
		#collision_shape.disabled = false
