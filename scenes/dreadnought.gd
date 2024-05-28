extends CharacterBody3D

const SPEED = 5
const ROTATION_SPEED = 1
const RELOAD_TIME = 5
const TARGETING_INACCURACY = 0
const DISPERSION = 0

var firing_positions
var firing_timer
var target_position

var random

signal shell_fired(shell, flight_path)

@export var model: PackedScene
@export var explosion_fx: PackedScene
@export var projectile: PackedScene

func _ready():
	firing_positions = $blockbench_export/Node/dreadnought/primary_weapons.find_children("*", "Marker3D", true)
	firing_timer = $FiringTimer
	firing_timer.start(1)
	random = RandomNumberGenerator.new()
	random.randomize()

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	#move_and_slide()
	
	
	##Aim the turrets
	if target_position != null:
		for turret in $blockbench_export/Node/dreadnought/primary_weapons.get_children():

			var turret_position3D = turret.global_position
			#var target_position = Vector3(turret_position3D.x-mouse_position3D.x, 0, turret_position3D.z-mouse_position3D.z)
			#print(turret_position3D)
			#target_position = $"../enemyDreadnought".global_position
			
			#replace this with a function call that takes min and max into account
			turret.look_at(target_position, Vector3(0,1,0))
			turret.rotate(Vector3(0,1,0), deg_to_rad(180))
	
	if firing_timer.is_stopped() && target_position != null:
		fire()
		firing_timer.start(RELOAD_TIME)
	
func fire():
	for emitter in firing_positions:
		# Calculate range, with dispersion and targeting inaccuracy
		var shell = load("res://scenes/shell.tscn").instantiate()

		
		var shell_destination = target_position
		var midpoint = emitter.global_position.lerp(target_position, 0.5)
		midpoint.y += emitter.global_position.distance_to(target_position) / 4
		
		var flight_path = Path3D.new()
		flight_path.position = emitter.global_position
		flight_path.curve = Curve3D.new()
		flight_path.curve.add_point(emitter.global_position)
		flight_path.curve.add_point(midpoint)
		flight_path.curve.add_point(shell_destination)
		
		shell_fired.emit(shell, flight_path)
		
		var fx = explosion_fx.instantiate()
		emitter.add_child(fx)
		fx.explode()
		
	print("FIRE!!!")
