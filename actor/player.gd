class_name Player
extends Node2D

signal player_turned

export var radius: float
export var line_width: float
export var circle_color: Color = Color.whitesmoke
export var line_color: Color = Color.black

export var movement_speed: float
export var rotation_speed_degrees: float

export var movement_acceleration_time: float
export var rotation_acceleration_time: float

export var movement_deceleration_time: float
export var rotation_deceleration_time: float

var linear_velocity: Vector2
var angular_velocity_degrees: float

var is_active := true

func _ready():
	$EditorSprite.visible = false


func _process(delta: float):	
	if is_active:
		handle_input(delta)
		update_physics(delta)
	
	update()
	
	
func _draw():
	draw_circle(Vector2(), radius, circle_color)
	draw_line(Vector2(), Vector2.RIGHT * radius, line_color, line_width, true)
	
	
func handle_input(delta: float):
	var previous_linear_velocity = linear_velocity
	var previous_angular_velocity_degrees = angular_velocity_degrees
	
	if Input.is_action_just_pressed("player_left") or \
	   Input.is_action_just_pressed("player_right"):
		emit_signal("player_turned")
	
	if Input.is_action_pressed("player_left"):
		linear_velocity *= 0
		angular_velocity_degrees += delta * -rotation_speed_degrees / rotation_acceleration_time

	elif Input.is_action_pressed("player_right"):
		linear_velocity *= 0
		angular_velocity_degrees += delta * rotation_speed_degrees / rotation_acceleration_time
		
	else:
		angular_velocity_degrees -= delta * sign(angular_velocity_degrees) * rotation_speed_degrees / rotation_deceleration_time
		
		if previous_angular_velocity_degrees * angular_velocity_degrees <= 0:
			angular_velocity_degrees = 0
		
		if Input.is_action_pressed("player_go_go"):
			linear_velocity += delta * get_direction_vector() * movement_speed / rotation_acceleration_time
		
		else:
			linear_velocity -= delta * linear_velocity.normalized() * movement_speed / rotation_deceleration_time	
			
			if previous_linear_velocity.dot(linear_velocity) <= 0:
				linear_velocity *= 0
				
	if Input.is_action_pressed("player_stop"):
		linear_velocity *= 0
		angular_velocity_degrees = 0
					
	angular_velocity_degrees = clamp(angular_velocity_degrees, -rotation_speed_degrees, rotation_speed_degrees)
	linear_velocity = linear_velocity.clamped(movement_speed)
			
			
func update_physics(delta: float):	
	position += linear_velocity * delta
	rotation_degrees += angular_velocity_degrees * delta
	

func get_direction_vector() -> Vector2:
	return Vector2(cos(rotation), sin(rotation))
