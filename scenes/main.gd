extends Node3D

@onready var path = $path
@onready var path_follow = $path_follow

var ready_to_move = false
var destination
var curve_point
var curve_distance = 300

var target_position
@onready var selected_player_ship = $playerDreadnought

var shell_flight_paths = []

#func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	#if(event.is_action_pressed("mouse_left")):
		#if(selected_player_ship == null):
			#print("Select a ship first")
		#else:
			#ready_to_move = false
			#path_follow.progress_ratio = 0
			#path.curve.clear_points()
			#destination = position
			#
			#curve_point = Vector3(curve_distance * sin(-selected_player_ship.rotation.y) + selected_player_ship.position.x, 0, curve_distance * cos(-selected_player_ship.rotation.y) + selected_player_ship.position.z)
			#
			#path.curve.add_point(selected_player_ship.position)
			#path.curve.add_point(destination, curve_point - destination)
			#path.curve.add_point(destination)
			#ready_to_move = true

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		target_position = position
		if selected_player_ship != null:
			selected_player_ship.target_position = target_position

func _on_enemy_dreadnought_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		target_position = $enemyDreadnought.position
		if selected_player_ship != null:
			selected_player_ship.target_position = target_position


func _on_player_dreadnought_input_event(camera, event, position, normal, shape_idx):
	if(event.is_action_pressed("mouse_left")):
		selected_player_ship = $playerDreadnought
		
func _on_player_dreadnought_shell_fired(shell, flight_path):
	shell.scale = Vector3(10, 10, 10)
	print(shell.is_node_ready())
	flight_path.add_child(PathFollow3D.new())
	flight_path.get_child(0).add_child(shell)
	shell_flight_paths.push_back(flight_path)

func _physics_process(delta):
	if ready_to_move: #Replace this with a state machine on the ship itself
		selected_player_ship.position = path_follow.position
		selected_player_ship.rotation.y = path_follow.rotation.y
		if path_follow.progress_ratio + 0.2 * delta < 1:
			path_follow.progress_ratio +=  0.2 * delta
	
	for path in shell_flight_paths:
		var shell_path_follow = path.get_child(0)
		shell_path_follow.position = path.position
		var shell = shell_path_follow.get_child(0)
		shell.position = shell_path_follow.position
		shell.rotation = shell_path_follow.rotation
		#print(shell.position)
		if shell_path_follow.progress_ratio + 0.05 * delta < 1:
			shell_path_follow.progress_ratio += 0.05 * delta
