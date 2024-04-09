extends RigidBody3D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
