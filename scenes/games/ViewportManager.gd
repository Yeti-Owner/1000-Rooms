extends Spatial

var quad_mesh_size
var is_mouse_inside = false
var is_mouse_held = false
var last_mouse_pos3D = null
var last_mouse_pos2D = null

onready var node_viewport = $Viewport
onready var node_quad = $Screen
onready var node_area = $Screen/Area

func _ready():
	node_area.connect("mouse_entered", self, "_mouse_entered_area")

func _mouse_entered_area():
	is_mouse_inside = true

func _unhandled_input(event):
	var is_mouse_event = false
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag]:
		if event is mouse_event:
			is_mouse_event = true
			break

	if is_mouse_event and (is_mouse_inside or is_mouse_held):
		handle_mouse(event)
	elif not is_mouse_event:
		node_viewport.input(event)


func handle_mouse(event):
	quad_mesh_size = node_quad.mesh.size
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		is_mouse_held = event.pressed
	
	var mouse_pos3D = find_mouse(event.global_position)
	
	is_mouse_inside = mouse_pos3D != null
	if is_mouse_inside:
		mouse_pos3D = node_area.global_transform.affine_inverse() * mouse_pos3D
		last_mouse_pos3D = mouse_pos3D
	else:
		mouse_pos3D = last_mouse_pos3D
		if mouse_pos3D == null:
			mouse_pos3D = Vector3.ZERO
	
	var mouse_pos2D = Vector2(mouse_pos3D.x, -mouse_pos3D.y)
	
	mouse_pos2D.x += quad_mesh_size.x / 2
	mouse_pos2D.y += quad_mesh_size.y / 2
	
	mouse_pos2D.x = mouse_pos2D.x / quad_mesh_size.x
	mouse_pos2D.y = mouse_pos2D.y / quad_mesh_size.y
	
	mouse_pos2D.x = mouse_pos2D.x * node_viewport.size.x
	mouse_pos2D.y = mouse_pos2D.y * node_viewport.size.y
	
	event.position = mouse_pos2D
	event.global_position = mouse_pos2D
	
	if event is InputEventMouseMotion:
		if last_mouse_pos2D == null:
			event.relative = Vector2(0, 0)
		else:
			event.relative = mouse_pos2D - last_mouse_pos2D
	last_mouse_pos2D = mouse_pos2D
	node_viewport.input(event)


func find_mouse(global_position):
	var camera = get_viewport().get_camera()
	var from = camera.project_ray_origin(global_position)
	var dist = find_further_distance_to(camera.transform.origin)
	var to = from + camera.project_ray_normal(global_position) * dist
	
	var result = get_world().direct_space_state.intersect_ray(from, to, [], node_area.collision_layer,false,true) #for 3.1 changes
	
	if result.size() > 0:
		return result.position
	else:
		return null


func find_further_distance_to(origin):
	var edges = []
	edges.append(node_area.to_global(Vector3(quad_mesh_size.x / 2, quad_mesh_size.y / 2, 0)))
	edges.append(node_area.to_global(Vector3(quad_mesh_size.x / 2, -quad_mesh_size.y / 2, 0)))
	edges.append(node_area.to_global(Vector3(-quad_mesh_size.x / 2, quad_mesh_size.y / 2, 0)))
	edges.append(node_area.to_global(Vector3(-quad_mesh_size.x / 2, -quad_mesh_size.y / 2, 0)))
	
	var far_dist = 0
	var temp_dist
	for edge in edges:
		temp_dist = origin.distance_to(edge)
		if temp_dist > far_dist:
			far_dist = temp_dist
	
	return far_dist
