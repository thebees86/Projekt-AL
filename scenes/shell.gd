extends RigidBody3D

const VELOCITY = 25

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#var gravity = 0
var velocity = Vector3(25, 10, 0)
var rot_velocity = Vector3(0, 0, 0)

@onready
var collision_shape = $projectile_collision

func _physics_process(delta):
	velocity.y -= gravity * delta
	position += velocity * delta
	
