tool

class_name Line
extends Node2D


export var width: float
export var color_palette: Gradient
export var cap_alpha_multiplier: float

onready var color := color_palette.interpolate(randf())


func _process(delta):
	update()


func _draw():
	var sp = get_start_point(true)
	var ep = get_end_point(true)
	
	draw_line(sp, ep, color, width, true)


func get_start_point(local = false) -> Vector2:
	return Vector2() if local else position
	

func set_start_point(point: Vector2, local = false):
	if local:
		position = point
	else:
		global_position = point


func get_end_point(local = false) -> Vector2:
	var ep = $EndPoint.position
	
	return ep if local else transform * ep
	

func set_end_point(point: Vector2, local = false):
	if local:
		$EndPoint.position = point
	else:
		$EndPoint.global_position = point
