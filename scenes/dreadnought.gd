extends CharacterBody3D



const SPEED = 5.0

@export var projectile: PackedScene
@export var model: PackedScene
#@onready var camera = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	#jk don't actually
	#if not is_on_floor():
	#	velocity.y -= gravity * delta
	
	#To prevent it inexplicably sinking into the floor or floating up
	#Because those are both things that keep happening and I don't know why
	velocity.y = 0

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	var is_firing = Input.is_action_just_pressed("fire")
	if(is_firing):
		fire()
	
func fire():
	#for turret in $blockbench_export/Node/dreadnought/primary_weapons.get_children():
		#var projectile1 = projectile.instantiate()
		#owner.add_child(projectile1)
		#projectile1.transform = turret.get_child(turret.get_child_count()-1).transform
		#var projectile2 = projectile.instantiate()
		#add_child(projectile2)
		#projectile2.transform = turret.Muzzle2.transform
		
	var shell1 = projectile.instantiate()
	owner.add_child(shell1)
	shell1.transform = $blockbench_export/Node/dreadnought/primary_weapons/A_turret/Muzzle1.global_transform
	
	var shell2 = projectile.instantiate()
	owner.add_child(shell2)
	shell2.transform = $blockbench_export/Node/dreadnought/primary_weapons/A_turret/Muzzle2.global_transform
	
	var shell3 = projectile.instantiate()
	owner.add_child(shell3)
	shell3.transform = $blockbench_export/Node/dreadnought/primary_weapons/P_turret/Muzzle1.global_transform
	
	var shell4 = projectile.instantiate()
	owner.add_child(shell4)
	shell4.transform = $blockbench_export/Node/dreadnought/primary_weapons/P_turret/Muzzle2.global_transform
	
	var shell5 = projectile.instantiate()
	owner.add_child(shell5)
	shell5.transform = $blockbench_export/Node/dreadnought/primary_weapons/X_turret/Muzzle1.global_transform
	
	var shell6 = projectile.instantiate()
	owner.add_child(shell6)
	shell6.transform = $blockbench_export/Node/dreadnought/primary_weapons/X_turret/Muzzle2.global_transform
	
	var shell7 = projectile.instantiate()
	owner.add_child(shell7)
	shell7.transform = $blockbench_export/Node/dreadnought/primary_weapons/Y_turret/Muzzle1.global_transform
	
	var shell8 = projectile.instantiate()
	owner.add_child(shell8)
	shell8.transform = $blockbench_export/Node/dreadnought/primary_weapons/Y_turret/Muzzle2.global_transform
		
	print("FIRE!!!")
	
