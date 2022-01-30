class_name Line
extends Node2D


export var width: float
export var cap_radius: float
export var color_palette: Gradient
export var cap_alpha_multiplier: float

onready var color := color_palette.interpolate(randf())

var cap_color: Color = Color.mintcream


func _process(delta):
	update()


func _draw():
	var sp = get_start_point(true)
	var ep = get_end_point(true)
	
	draw_line(sp, ep, color, width, true)
	draw_circle(sp, cap_radius, cap_color)
	draw_circle(ep, cap_radius, cap_color)


func get_start_point(local = false) -> Vector2:
	var sp = $StartPoint.position
	
	return sp if local else transform * sp
	

func set_start_point(point: Vector2, local = false):
	if local:
		$StartPoint.position = point
	else:
		$StartPoint.global_position = point


func get_end_point(local = false) -> Vector2:
	var ep = $EndPoint.position
	
	return ep if local else transform * ep
	

func set_end_point(point: Vector2, local = false):
	if local:
		$EndPoint.position = point
	else:
		$EndPoint.global_position = point
