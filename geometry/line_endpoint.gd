tool

class_name LineEndpoint
extends Position2D

export var cap_radius: float
var cap_color: Color = Color.mintcream

func _process(delta):
	update()

func _draw():
	draw_circle(Vector2(), cap_radius, cap_color)
