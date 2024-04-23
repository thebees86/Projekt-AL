extends RigidBody3D

#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 3
var velocity = Vector3(20, 10, 0)
var rot_velocity = Vector3(0, 0, 0)

@onready
var collision_shape = $projectile_collision

func _physics_process(delta):
	velocity.y -= gravity * delta
	position += velocity * delta
	
