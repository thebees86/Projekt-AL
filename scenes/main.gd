extends Node3D

@onready var path = $path
@onready var path_follow = $path/PathFollow3D

var ready_to_move = false
var destination
var curve_point
var curve_distance = 300

var target
var selected_player_ship


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		if(selected_player_ship == null):
			print("Select a ship first")
		else:
			ready_to_move = false
			path_follow.progress_ratio = 0
			path.curve.clear_points()
			destination = position
			
			#curve_point = Vector3(curve_distance * sin(-selected_player_ship.rotation.y) + selected_player_ship.position.x, 0, curve_distance * cos(-selected_player_ship.rotation.y) + selected_player_ship.position.z)
			
			path.curve.add_point(selected_player_ship.position)
			#path.curve.add_point(destination, curve_point - destination)
			path.curve.add_point(destination)
			ready_to_move = true


func _on_enemy_dreadnought_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		target = $enemyDreadnought
		if selected_player_ship != null:
			selected_player_ship.target_position = target.position


func _on_player_dreadnought_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		selected_player_ship = $playerDreadnought

func _physics_process(delta):
	if ready_to_move: #Replace this with a state machine on the ship itself
		selected_player_ship.position = path_follow.position
		selected_player_ship.rotation.y = path_follow.rotation.y
		if path_follow.progress_ratio + 0.2 * delta < 1:
			path_follow.progress_ratio +=  0.2 * delta
		
