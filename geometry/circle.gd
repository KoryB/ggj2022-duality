class_name Circle
extends Node2D

const ARC_POINT_COUNT: int = 200

export var width_bounds: Vector2
export var radius_ratio_bounds: Vector2
export var offset_bounds: Vector2

export var line_path: NodePath
onready var line: Line = get_node(line_path)

onready var width = rand_range(width_bounds.x, width_bounds.y)
onready var radius_ratio = rand_range(radius_ratio_bounds.x, radius_ratio_bounds.y)
onready var offset_size = rand_range(offset_bounds.x, offset_bounds.y)
var color: Color

var radius: float

# Called when the node enters the scene tree for the first time.
func _ready():
	color = line.color
	sync_with_line()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sync_with_line()
	update()
	

func _draw():	
	draw_arc(Vector2(), radius, 0, 2 * PI, ARC_POINT_COUNT, color, width, true)
	
	
func sync_with_line():
	radius = get_radius_from_line() * radius_ratio
	
	var c = get_center_from_line()
	var offset = get_unit_offset_from_line() * offset_size * radius
	position = c + offset
	
	
func get_center_from_line() -> Vector2:
	return (line.get_start_point() + line.get_end_point()) / 2
	

func get_radius_from_line() -> float:
	return (line.get_end_point() - line.get_start_point()).length() / 2


func get_unit_offset_from_line() -> Vector2:
	var delta = line.get_end_point() - line.get_start_point()
	var delta_normalized = delta.normalized()
	var unit_offset = Vector2(-delta_normalized.y, delta_normalized.x)
	
	return unit_offset
