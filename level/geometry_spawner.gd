class_name GeometrySpawner
extends Node

const LineScene := preload("res://geometry/line.tscn")
const CircleScene := preload("res://geometry/circle.tscn")

export var player_path: NodePath
onready var player: Player = get_node(player_path)

var player_line: Line
var player_circle: Circle

func _ready():
	player_line = spawn_player_line()
	player_circle = spawn_player_circle(player_line)
	
	
func _process(delta: float):
	player_line.set_end_point(player.position)


func create_line(start_position: Vector2) -> Line:
	var line = LineScene.instance()
	line.set_start_point(start_position)
	
	return line
	

func spawn_player_line() -> Line:
	var line = create_line(player.position)
	line.set_end_point(player.position)
	add_child(line)
	
	return line
	

func create_circle(line: Line) -> Circle:
	var circle = CircleScene.instance()
	circle.line_path = line.get_path()
	
	return circle
	

func spawn_player_circle(line: Line) -> Circle:
	var circle = create_circle(line)
	add_child(circle)
	
	return circle


func _on_Player_player_turned():
	remove_child(player_line)
	remove_child(player_circle)
	
	$Lines.add_child(player_line)
	$Circles.add_child(player_circle)
	
	player_circle.line_path = player_line.get_path()
	
	player_line = spawn_player_line()
	player_circle = spawn_player_circle(player_line)
	
