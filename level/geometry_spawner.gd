class_name GeometrySpawner
extends Node2D

const LineScene := preload("res://actor/geometry/line.tscn")
const CircleScene := preload("res://actor/geometry/circle.tscn")

export var line_count: int
export var bounds: Rect2
export var line_length_bounds: Vector2

func _ready():
	randomize()
	add_children()
	
	
func add_children():
	remove_children()
	
	var a = get_random_point()
	for i in range(line_count):
		var b = get_random_point_from(a)
		
		var line = add_line_child(a, b)
		var circle = add_circle_child(line)
		a = b
		
func remove_children():
	for c in get_children():
		c.queue_free()


func add_line_child(start_point: Vector2, end_point: Vector2):
	var line = LineScene.instance()
	
	line.set_start_point(start_point)
	line.set_end_point(end_point)
	add_child(line)
	
	return line
	
	
func add_circle_child(line: Line):
	var line_path = line.get_path()
	var circle = CircleScene.instance()
	
	circle.line_path = line_path
	add_child(circle)
	
	return circle
	

func get_random_point() -> Vector2:
	return bounds.position + Vector2(randf(), randf()) * bounds.size


func get_random_point_from(from: Vector2) -> Vector2:
	while true:
		var angle = randf() * 2 * PI
		var length = rand_range(line_length_bounds.x, line_length_bounds.y)
		var offset = Vector2(cos(angle), -sin(angle)) * length
		
		var to = from + offset
		
		if bounds.has_point(to):
			return to
			
	return Vector2()
	


func _on_Button_pressed():
	add_children()
