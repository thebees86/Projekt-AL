extends Node3D

const ROTATION_SPEED = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var viewport = get_viewport()
	var mouse_position = viewport.get_mouse_position()
	var camera = viewport.get_camera_3d()
	
	var origin = camera.project_ray_origin(mouse_position)
	var direction = camera.project_ray_normal(mouse_position)
	
	var end = origin + direction * camera.far
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	var result = space_state.intersect_ray(query)
	
	var mouse_position3D:Vector3 = result.get("position", end)
	#print(mouse_position3D)
	
	
	$Node/dreadnought/A_turret.look_at(Vector3(mouse_position3D.x,0,mouse_position3D.z), Vector3(0,1,0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
