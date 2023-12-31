extends Camera2D

@export var zoom_speed := 0.1
@export var pan_speed := 1.0
@export var rotate_speed := 1.0
@export var can_zoom: bool
@export var can_rotate: bool
@export var can_pan: bool

var touch_points: Dictionary = {}
var start_distance
var start_zoom
var start_angle
var current_angle
var current_dist
var touch_point_position

func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif  event is InputEventScreenDrag:
		handle_drag(event)
		
	if touch_points.size() == 2:
		touch_point_position = touch_points.values()
		start_distance = touch_point_position[0].distance_to(touch_point_position[1])
		
		start_zoom = zoom
	elif touch_points.size() < 2:
		start_distance = 0
func handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)

func handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	print("teste")
	if touch_points.size() == 1:
		offset -= event.relative * pan_speed / zoom.x 
	elif touch_points.size() == 2:
		touch_point_position = touch_points.values()
		current_dist= touch_point_position[0].distance_to(touch_point_position[1])
		var zoom_factor = start_distance / current_dist
		if can_zoom:
			zoom = start_zoom / zoom_factor
			
		limit_zoom(zoom)

func limit_zoom(new_zoom):
	if new_zoom.x < 0.1:
		zoom.x = 0.1
	if new_zoom.y < 0.1:
		zoom.y = 0.1
	if new_zoom.x > 10:
		zoom.x = 10
	if new_zoom.y > 10:
		zoom.y = 10
