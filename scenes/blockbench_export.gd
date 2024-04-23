extends Node3D

@export var projectile: PackedScene

const ROTATION_SPEED = 1
const RELOAD_TIME = 5

var firing_positions
var firing_timer
var target_position

# Called when the node enters the scene tree for the first time.
func _ready():
	firing_positions = $Node/dreadnought/primary_weapons.find_children("*", "Marker3D", true)
	firing_timer = $FiringTimer
	firing_timer.start(1)
	#print(firing_positions)
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
	
	for turret in $Node/dreadnought/primary_weapons.get_children():

		var turret_position3D = turret.global_transform.origin
		var target_position = Vector3(turret_position3D.x-mouse_position3D.x, 0, turret_position3D.z-mouse_position3D.z)
		#print(turret_position3D)
		turret.look_at(target_position, Vector3(0,1,0))
	#var turret_position3D:Vector3 = $Node/dreadnought/primary_weapons/A_turret.global_transform.origin
	#print(turret_position3D)
	
	$Node/dreadnought/primary_weapons/A_turret.look_at(Vector3(-mouse_position3D.x,0,-mouse_position3D.z), Vector3(0,1,0))
	#$Node/dreadnought/primary_weapons/A_turret.rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), delta*100.0)
	
	if firing_timer.is_stopped():
		fire()
		firing_timer.start(RELOAD_TIME)
	
func fire():
	for emitter in firing_positions:
		var shell = projectile.instantiate()
		shell.global_transform = emitter.global_transform
		shell.rotation = emitter.rotation
		owner.add_child(shell)
	print("FIRE!!!")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
